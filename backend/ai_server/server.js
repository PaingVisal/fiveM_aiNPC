const express = require('express');
const axios = require('axios');
const fs = require('fs');
require('dotenv').config();

const app = express();
app.use(express.json());

const npcPersonalities = {
    "john": "You are John, a friendly shopkeeper.",
    "mike": "You are Mike, a retired detective with deep knowledge of the city.",
    "lisa": "You are Lisa, a street artist with a creative mind."
};

app.post('/chat', async (req, res) => {
    const { npcName, prompt } = req.body;
    const personality = npcPersonalities[npcName] || "You are a generic NPC.";

    try {
        const response = await axios.post("https://api.openai.com/v1/chat/completions", {
            model: "gpt-4",
            messages: [{ role: "system", content: personality }, { role: "user", content: prompt }],
            max_tokens: 100
        }, {
            headers: { Authorization: `Bearer ${process.env.OPENAI_API_KEY}` }
        });

        const reply = response.data.choices[0].message.content;
        const voiceUrl = await generateVoice(reply);

        res.json({ reply, voiceUrl });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: "AI request failed." });
    }
});

async function generateVoice(text) {
    try {
        const response = await axios.post("https://api.elevenlabs.io/v1/text-to-speech", {
            text,
            voice: "Josh"  // Change this to a different voice if needed
        }, {
            headers: { Authorization: `Bearer ${process.env.ELEVENLABS_API_KEY}` }
        });

        const audioUrl = response.data.audio_url;
        return audioUrl;
    } catch (error) {
        console.error("TTS Error:", error);
        return null;
    }
}

app.listen(3001, () => console.log("AI Server running on port 3001"));
