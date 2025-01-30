# NPC AI with ChatGPT and Voice Playback (FiveM)

A FiveM resource that integrates **ChatGPT AI** with NPCs, allowing players to interact with NPCs through text and voice. This resource uses **QBCore** for seamless integration into your server.

## Features

| Feature                        | Description                                                                 |
|--------------------------------|-----------------------------------------------------------------------------|
| **NPC AI Interaction**         | Players can interact with NPCs by pressing `E` and chatting with them via text input. |
| **Voice Playback**             | NPC responses are read aloud using pre-generated voice files, making the interaction more immersive. |
| **QBCore Integration**         | Built with **QBCore** for easy integration with QBCore servers.             |
| **Customizable NPCs**          | Easily add new NPCs with customizable names, models, and locations.         |
| **Responsive UI**              | Includes a responsive NUI for audio playback and interaction.              |

## Installation

### 1. Download the Resource

| Step                | Command                                                        |
|---------------------|----------------------------------------------------------------|
| **Clone the Repo**   | `git clone https://github.com/PaingVisal/fiveM_aiNPC` |
| **Place in Resources**| Place the npc_ai from frontend/ in your `resources/` folder (or any preferred location). place ai_server to outside and run it before run fivem server. |

### 2. Update `config.lua`

Customize the NPCs you want to spawn and their properties:

| Attribute  | Description                                         |
|------------|-----------------------------------------------------|
| **name**   | The NPC's name.                                     |
| **model**  | The model hash for the NPC (e.g., "a_m_m_business_01"). |
| **coords** | The spawn coordinates for the NPC in the world.     |

Example:
```lua
NPCs = {
    { name = "John", model = "a_m_m_business_01", coords = vector3(100.0, -1000.0, 29.0) },
    { name = "Anna", model = "a_f_m_beach_01", coords = vector3(150.0, -1005.0, 29.0) }
}
