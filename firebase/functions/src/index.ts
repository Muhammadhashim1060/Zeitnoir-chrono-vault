import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { OpenAI } from 'openai';

admin.initializeApp();

const SYSTEM_PROMPT = `You are Depth.EI, an empathetic but tough financial coach. 
Your job is to push users out of debt and into discipline. 
Be motivational, use challenges, set deadlines, and keep users accountable. 
Speak like a personal coach who genuinely believes in their greatness.
Never let them give up. 
End each message with energy and belief.`;

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

export const aiCoach = functions.https.onCall(async (data, context) => {
  const messages = (data?.messages ?? []) as Array<{role: string; content: string}>;
  try {
    const completion = await openai.chat.completions.create({
      model: 'gpt-4o-mini',
      messages: [
        { role: 'system', content: SYSTEM_PROMPT },
        ...messages.map(m => ({ role: m.role as any, content: m.content })),
      ],
      temperature: 0.9,
    });

    const reply = completion.choices?.[0]?.message?.content ?? 'Stay focused. You can do this!';

    return { reply };
  } catch (err: any) {
    console.error('aiCoach error', err);
    return { reply: 'Coach is unavailable. Try again shortly.' };
  }
});

// Flutterwave webhook for subscription & wallet events
export const flutterwaveWebhook = functions.https.onRequest(async (req, res) => {
  try {
    const event = req.body;
    const uid = event?.data?.meta?.uid as string | undefined;
    const amount = Number(event?.data?.amount ?? 0);

    if (uid) {
      const userRef = admin.firestore().collection('users').doc(uid);
      await admin.firestore().runTransaction(async (tx) => {
        const snap = await tx.get(userRef);
        const balance = (snap.data()?.wallet_balance ?? 0) as number;
        tx.update(userRef, { wallet_balance: Number((balance + amount).toFixed(2)) });
      });

      await admin.firestore().collection('transactions').doc(uid).collection('items').add({
        type: 'flutterwave_event',
        amount,
        raw: event,
        created_at: admin.firestore.FieldValue.serverTimestamp(),
      });
    }

    res.status(200).json({ received: true });
  } catch (e) {
    console.error('flutterwaveWebhook error', e);
    res.status(200).json({ received: true });
  }
});

// Broadcast message to all users (admin only)
export const broadcast = functions.https.onCall(async (data, context) => {
  const uid = context.auth?.uid;
  const isAdmin = uid ? (await admin.auth().getUser(uid)).customClaims?.admin === true : false;
  if (!isAdmin) {
    throw new functions.https.HttpsError('permission-denied', 'Admin only');
  }
  const message = (data?.message ?? '') as string;
  const snap = await admin.firestore().collection('users').get();
  const batch = admin.firestore().batch();
  for (const doc of snap.docs) {
    const inbox = admin.firestore().collection('inbox').doc(doc.id).collection('items').doc();
    batch.set(inbox, {
      message,
      created_at: admin.firestore.FieldValue.serverTimestamp(),
    });
  }
  await batch.commit();
  return { ok: true };
});
