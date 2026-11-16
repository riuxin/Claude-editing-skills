# Claude Code as a professional video / content studio

Every video, motion, editing and content-creation skill I could verify on GitHub, graded and sorted by the job you need done.

Compiled 2026-11-17 · 515 video skills security-graded by Agent Skills Hub, plus ~320 adjacent content skills from live GitHub search · every link below resolved live today, no dead repos.

Target: **Claude Code v2.1.325** on this machine (Opus 5.5 models — the list flags which skills were built for them).

> **Already done for you:** `ffmpeg-skill` and `davinci-resolve-mcp` are installed into `~/.claude/skills/` and verified (both have a real `SKILL.md`; ffmpeg-skill is on 3.10.1 with all 42 tools). The rest of the stack is one command away — see the end.


---

## How these install (checked against code.claude.com/docs, not guessed)

Three mechanisms, all live in 2.1.x:

| Mechanism | Where it lives | Scope |
|---|---|---|
| **Personal skill** | `~/.claude/skills/<name>/SKILL.md` | every project, this machine |
| **Project skill** | `<repo>/.claude/skills/<name>/SKILL.md` | that repo only, commits with it |
| **Plugin** (repo with `.claude-plugin/marketplace.json`) | installed via `/plugin` | wherever enabled, namespaced `/plugin:skill` |

```bash
# personal: clone the repo, copy the skill folder
git clone --depth 1 https://github.com/<owner>/<repo> /tmp/s && \
  cp -r /tmp/s/skills/<skill-name> ~/.claude/skills/

# plugin marketplace (only works if the repo ships .claude-plugin/marketplace.json)
/plugin marketplace add <owner>/<repo>
/plugin install <plugin-name>@<marketplace-name>

# inside a session
/skills          # list what's loaded
/skill-doctor    # what each skill costs in context and how often it fires
/reload-plugins  # after changing a plugin's hooks or MCP config
```

**Two warnings that matter here:**

1. Every loaded skill costs context on **every** turn whether or not it fires. Do not install a 56-skill repo and a 42-skill repo and a 41-skill repo at once. Install one base, then add single skills. `/skill-doctor` tells you the tax.
2. On this machine `~/.claude/skills/` is 102 **symlinks into `C:\Users\riu\.agents\skills`**, which Hermes also reads. Copy new skill folders in as real directories (not symlinks into that shared tree) unless you want them in both agents.

### Prereqs, verified on this machine

| Tool | Status |
|---|---|
| ffmpeg | 9.0.1 ✓ |
| node / npm | 26.12.1 / 11.20.0 ✓ |
| python | 3.14.9 ✓ |
| git | 2.53.0 ✓ |
| claude | 2.1.325 ✓ |

Almost every skill in this document needs only these four. The ones that need an API key (HeyGen, Higgsfield, ElevenLabs, MiniMax, Seedance) say so.

---

## Where the long tail lives

Four indexes that are worth bookmarking, because the ecosystem moves weekly:

| Index | What it is |
|---|---|
| [zhuyansen/awesome-claude-video-skills](https://github.com/zhuyansen/awesome-claude-video-skills) | **The** index: 515 repos, each read and security-graded, categorised, with live filters at [agentskillshub.top/best/claude-video-skills](https://agentskillshub.top/best/claude-video-skills/). Refreshed every 8 hours. They also ran 16 of them end to end and published timings — that data is quoted below. |
| [JuneYaooo/awesome-ai-media-skills](https://github.com/JuneYaooo/awesome-ai-media-skills) | Graded list of video-gen MCPs, social MCPs and content skills (A–C grades, English). |
| [opusvideo/awesome-claude-video](https://github.com/opusvideo/awesome-claude-video) | Videos people actually made with Opus 5.5, with the original posts — the taste reference. |
| [rohitg00/awesome-claude-design](https://github.com/rohitg00/awesome-claude-design) | DESIGN.md prompts by aesthetic family, remix recipes, video teardowns. |

Full machine-readable dump of everything in this document: `claude_code_content_skills.csv` (836 unique repos, sortable, one row per repo).

---

## What the bake-off showed (16 skills, same brief)

Agent Skills Hub ran 16 of the top skills on an identical 15-second brief:

- All 16 produced a playable file that passed every check — **and so did Claude Code with no skill at all, in 4.4 minutes.**
- Fastest finished film with sound: **explainroo, 2.0 min**. Slowest: **hyperframes, 23.5 min**.
- 10 of 16 had a look of its own; 6 looked like the default.

Conclusion, and this is the useful part: a skill earns its place by giving you a **look**, a **workflow**, or **footage to edit**. For a plain 15-second promo you may not need one. For a motion-graphics piece, a talking-head reel, or a DaVinci pass, you absolutely do.

---
## 1. All-in-one production systems — pick one as the base

These own the whole pipeline: script → assets → voice → render → file. Everything after this section is a specialist you bolt on.

| Skill (repo) | ★ | Grade | What it does |
|---|---:|---|---|
| [hyperframes](https://github.com/heygen-com/hyperframes) | 85.1k | SAFE | HTML in, MP4 out. The most-starred video tool on GitHub (85k) and the engine half the list sits on. |
| [OpenMontage](https://github.com/OpenMontageInc/OpenMontage) | 80.9k | — | 12 production pipelines, 100+ tools, 700+ agent skills. Biggest single system — graded CAUTION, read its scripts first. |
| [hypit](https://github.com/hypit-ai/hypit) | 30.1k | SAFE | Clones a viral video end to end: face, pacing, shot list. Trend-jacking, not original work. |
| [openmotion](https://github.com/nexu-io/openmotion) | 10.0k | SAFE | Open CapCut alternative — reference video in, editable motion project out. |
| [skills](https://github.com/remotion-dev/skills) | 7.3k | SAFE | Remotion's own skills. The most reliable render path in testing (4.5 min); bring your own design direction. |
| [claude-code-video-toolkit](https://github.com/digitalsamba/claude-code-video-toolkit) | 2.6k | SAFE | Script → AI voiceover → music → clips → render, MIT, open source. Best default for talking content. |
| [skills](https://github.com/vibe-motion/skills) | 1.7k | SAFE | Tested 3rd of 16 at 4.4 min with a look of its own. |
| [motion-skills](https://github.com/iart-ai/motion-skills) | 1.7k | SAFE | 56 separate skills (motion graphics, animation, video). Best modular base if you want to assemble your own studio. |
| [skills](https://github.com/video-db/skills) | 145 | SAFE | Server-side video workflows: ingest, understand, search, edit, stream. For pipelines over big libraries. |
| [kinocut](https://github.com/KyaniteLabs/kinocut) | 268 | — | Guardrailed editing MCP server: FFmpeg, HyperFrames, repurposing. Local, fast, free. |
| [avenoxskills](https://github.com/avenoxai/avenoxskills) | 152 | — | Production skills incl. a video pipeline plus monorepo/agent-fleet utilities. |
| [guizang-product-video-skill](https://github.com/op7418/guizang-product-video-skill) | 947 | SAFE | Product/software-update films reusing real components — storyboard, original score, SFX, render. |
---

## 2. Motion graphics — the "motion" family

Every frame written as code (Canvas / HTML / SVG / WebGL / Remotion), not generated video. This is the category that makes output look designed instead of AI-generic.

| Skill (repo) | ★ | Grade | What it does |
|---|---:|---|---|
| [bang-motion](https://github.com/bangtutorial/bang-motion) | 2.3k | SAFE | Browser motion graphics: openers, promos, bumpers, kinetic typography, five explainer styles. |
| [motion-graphics-skills](https://github.com/charlie947/motion-graphics-skills) | 694 | SAFE | 13 skills, launch-grade motion. Every frame is code — no After Effects, no video generation. |
| [motion-graphics](https://github.com/Barty-Bart/motion-graphics) | 1.3k | SAFE | Motion-graphics skills built specifically for talking-head footage. |
| [claude-motion-design](https://github.com/howseen-ai/claude-motion-design) | 837 | CAUTION | Pure-code motion design: HTML + Playwright + ffmpeg. CAUTION grade. |
| [lottie](https://github.com/diffusionstudio/lottie) | 5.8k | SAFE | Production-ready Lottie animations — the format you hand to a dev or use on the web. |
| [motion-video-kit](https://github.com/echris6/motion-video-kit) | 1.4k | SAFE | Premium business videos with an independent critic loop. Slowest of the good ones (~22 min) and the best-looking. |
| [product-launch-motion](https://github.com/AbubakrChan/product-launch-motion) | 473 | SAFE | Dribbble-level launch films: one shape that never cuts, springs, camera moves. |
| [motionmaxxing](https://github.com/Tejashmakwana/motionmaxxing) | 1.6k | SAFE | Takes AI-slop motion and re-grades it until it looks designed. |
| [onetake](https://github.com/feitangyuan/onetake) | 4.2k | SAFE | Films that never cut — every beat grows out of the one before. |
| [Motion-graphics-skill](https://github.com/mattypark/Motion-graphics-skill) | 67 | SAFE | Plan → animate → grade, multi-agent. Cross-harness (Claude Code, Codex, Cursor). |
| [motion-design-skills](https://github.com/iart-ai/motion-design-skills) | 238 | SAFE | Motion-design fundamentals + engines + brand elements as installable skills. |
| [RuiC-motion-reel](https://github.com/HRuiCcc/RuiC-motion-reel) | 201 | SAFE | One-line brief → motion promo; duration computed from BPM × bars. |
| [motion-design-with-claude-and-codex](https://github.com/LobzyJay/motion-design-with-claude-and-codex) | 41 | — | Motion design driven inside Blender and After Effects. |
| [motion-forge-plugin](https://github.com/arielaizn/motion-forge-plugin) | 4 | — | After-Effects-level motion written 100% in code (Canvas/WebGL). |
| [skills](https://github.com/blixvip/skills) | 5 | — | Drop-in SKILL.md folders: motion graphics, AE scripting, typography. |
| [claude-editing-skills](https://github.com/pihu26112005/claude-editing-skills) | 17 | — | 76 motion-graphics skills bundled: animated captions, titles, frames. |
| [mografy](https://github.com/zz41354899/mografy) | 58 | CAUTION | Create, preview and export Canvas motion graphics from Claude Code. |
---

### Motion sub-specialists: type, logos, data, maps

Narrow skills that do one motion job well.

| Skill (repo) | ★ | Grade | What it does |
|---|---:|---|---|
| [kinetic-typography-skills](https://github.com/iart-ai/kinetic-typography-skills) | 29 | SAFE | Kinetic typography — type that moves on beat. |
| [YouTube-AI-Motion-Graphics](https://github.com/sirioberati/YouTube-AI-Motion-Graphics) | 213 | — | 74 animated HTML explainer boards: charts, diagrams, Venn, timelines. |
| [pixel2motion](https://github.com/nolangz/pixel2motion) | 2.7k | SAFE | Raster logo in → smooth SVG animation, HTML demo, GIF/MP4 out. |
| [data-animation-skills](https://github.com/iart-ai/data-animation-skills) | 19 | SAFE | Data-driven animation: numbers and charts that animate. |
| [javascript-animation-skills](https://github.com/iart-ai/javascript-animation-skills) | 67 | SAFE | JavaScript animation skills (p5/canvas patterns). |
| [map-motion](https://github.com/SpaceZephyr/map-motion) | 124 | SAFE | Map motion from real routes/borders/satellite: earth dive, journeys, flight paths. |
| [gif-factory](https://github.com/WoYun520/gif-factory) | 1.9k | SAFE | GIF factory: pixel art, mascots, clay characters, animated posters. |
| [anidoodle](https://github.com/alexgreensh/anidoodle) | 1.8k | SAFE | Art and animation as code: illustrations, loops, interactive web art. |
| [riso-windowseat](https://github.com/sevenevesai/riso-windowseat) | 319 | SAFE | Procedural risograph films, single-file HTML. |
---

## 3. Editing real footage — cuts, captions, reframe, effects

Footage-based work: transcription-driven cutting, dead-air removal, auto captions, B-roll, vertical reframe, colour.

| Skill (repo) | ★ | Grade | What it does |
|---|---:|---|---|
| [video-editor-skills](https://github.com/appariciojunior/video-editor-skills) | 453 | — | First-pass editor in DaVinci: transcript cuts, vlog pacing, assembly. |
| [FireRed-OpenStoryline](https://github.com/FireRedTeam/FireRed-OpenStoryline) | 3.7k | SAFE | Editing agent that turns manual timelines into expressed intentions. |
| [OpenChatCut](https://github.com/0xsline/OpenChatCut) | 3.1k | SAFE | Local-first conversational editor with a real multi-track timeline. |
| [baocut](https://github.com/JimLiu/baocut) | 1.8k | SAFE | Transcribe, subtitle, translate, dub, cut — with an editable timeline. |
| [pireel](https://github.com/pireel/pireel) | 1.4k | SAFE | Captions, cuts, B-roll, then export to Premiere and DaVinci. |
| [cartcut](https://github.com/cartesiancs/cartcut) | 832 | SAFE | Open-source agent video editor, built to beat commercial tools. |
| [ghost-editor](https://github.com/kurbaitaev/ghost-editor) | 574 | SAFE | Raw talking-head take in, finished reel out. |
| [claude-video-effects](https://github.com/Vibha-Ramprakash/claude-video-effects) | 1.0k | SAFE | 51 video effects with face tracking: drop a clip, type /effects orbit. |
| [Video-editing-effects](https://github.com/lowdevco/Video-editing-effects) | 34 | — | Watches your footage and adds effects that fit it. |
| [herk-edit-kit](https://github.com/nateherkai/herk-edit-kit) | 2.9k | — | 15 skills by Nate Herk: transcripts, reels, YouTube Shorts end to end. |
| [ai-video-editing-skills](https://github.com/AskEditor/ai-video-editing-skills) | 5 | — | 41 skills: auto captions, cut pauses and retakes. |
| [video-editing-skill](https://github.com/6missedcalls/video-editing-skill) | 54 | — | Trim, jump-cut, Hormozi-style captions. |
| [video-editing-skill](https://github.com/social-media-skills/video-editing-skill) | 5 | — | Free talking-head editor skill for Claude Code / Codex / Cursor. |
| [chengfeng-videocut-skills](https://github.com/Agentchengfeng/chengfeng-videocut-skills) | 3.2k | SAFE | Video-editing agent built entirely on Claude Code skills. |
| [video-recap-skills](https://github.com/zenstory-ai/video-recap-skills) | 630 | SAFE | Auto shot detection, narration script, voice, CapCut draft export — no GPU. |
| [Claude-Soundbite-Editor](https://github.com/ckonteos80/Claude-Soundbite-Editor) | 15 | — | Premiere transcript JSON + a described intention → cut plan. |
| [color-grade-ai](https://github.com/isaacrowntree/color-grade-ai) | 39 | — | Generates real .cube LUTs for Resolve/Premiere colour grading. |
| [eva-video-style](https://github.com/RoverEva/eva-video-style) | 68 | SAFE | Talking-head templates: cinematic effects, motion graphics, animated captions. |
---

## 4. Pro NLE bridges — DaVinci Resolve, Premiere Pro, After Effects

Do not render in code when you already own the timeline. These drive the actual application over MCP / ExtendScript.

| Skill (repo) | ★ | Grade | What it does |
|---|---:|---|---|
| [davinci-resolve-mcp](https://github.com/lordhoell/davinci-resolve-mcp) | 27 | — | MCP + skill exposing 440+ Resolve scripting API calls. The deepest Resolve control here. |
| [davinci-resolve-claude-skills](https://github.com/ChaiWithJai/davinci-resolve-claude-skills) | 35 | — | Resolve skills written from a DevRel/content-creator angle. |
| [resolve-cut](https://github.com/Developh/resolve-cut) | 6 | — | Claude edits, renders and checks videos inside Resolve Studio. |
| [open-fusion-mcp](https://github.com/legionsound/open-fusion-mcp) | 15 | — | 179 checked Fusion operations for motion design in Resolve. |
| [Adobe_Premiere_Pro_MCP](https://github.com/hetpatel-11/Adobe_Premiere_Pro_MCP) | 883 | SAFE | Premiere Pro MCP for AI-driven editing. |
| [premiere-pro-mcp](https://github.com/leancoderkavy/premiere-pro-mcp) | 538 | SAFE | Independent, local-first Premiere MCP server. |
| [claude-premiere-pro-skills](https://github.com/jakob2912/claude-premiere-pro-skills) | 2 | — | Edits Reels/TikToks/Shorts inside Premiere via MCP bridge. |
| [premiere-skills](https://github.com/fuuuuuuma/premiere-skills) | 15 | — | /cut for silence removal, /srt for subtitle generation. |
| [premiere-ai-skills](https://github.com/stefanwebb/premiere-ai-skills) | 7 | — | Drives Premiere plus AI-assisted production workflows. |
| [prep](https://github.com/ISMAIL-debug-ctrl/prep) | 4 | — | Raw footage folder → Premiere project with synced assembly and rough cut. |
| [Claude-Soundbite-Editor](https://github.com/ckonteos80/Claude-Soundbite-Editor) | 15 | — | Premiere-transcript aware cutting. |
| [adobe-suite-agent-skills](https://github.com/ZEROTCREATIVE/adobe-suite-agent-skills) | 3 | — | 50+ ExtendScript automations for After Effects and Premiere. |
| [claude-after-effects-skill](https://github.com/AnmolChandiok/claude-after-effects-skill) | 5 | SAFE | Coded video → fully editable After Effects project. |
| [claude-after-effects-skills](https://github.com/vlad7329-debug/claude-after-effects-skills) | 3 | — | Claude builds animation inside your open AE, with real keyframes. |
| [claude-skills](https://github.com/dima-rdnv/claude-skills) | 2 | — | Production-tested skills for Houdini, C4D, Unreal, AE, Premiere. |
| [agentic-video-editing-collab](https://github.com/roysahar11/agentic-video-editing-collab) | 5 | — | Agent + human collaboration on Premiere/Resolve jobs. |
| [motion-cut](https://github.com/featherofawhale-crypto/motion-cut) | 2 | — | Storyboard → visual motionboard timeline for Resolve/Premiere. |
| [story-first-video-editing](https://github.com/Fred-In-tech/story-first-video-editing) | 4 | — | Story-first professional editing discipline. |
| [video-editor-hivemind](https://github.com/emmett007/video-editor-hivemind) | 2 | — | A Premiere skill family that compounds across projects. |
---

## 5. Shorts, reels, faceless channels

9:16 vertical, hooks on beat, captions word-by-word, ready for Reels / Shorts / TikTok.

| Skill (repo) | ★ | Grade | What it does |
|---|---:|---|---|
| [claude-animated-shorts](https://github.com/mromidev/claude-animated-shorts) | 3.7k | — | Viral animated story shorts: 2D characters in a 3D world, three.js + Remotion. |
| [claude-animation-skills](https://github.com/artemnovitckii/claude-animation-skills) | 819 | SAFE | Six skills that make reels with zero footage: 3D cartoon explainer, and more. |
| [claude-faceless-shorts-creator](https://github.com/hassancs91/claude-faceless-shorts-creator) | 367 | SAFE | Faceless Shorts factory: pure-TSX Remotion visuals, ElevenLabs voice. |
| [clipify](https://github.com/louisedesadeleer/clipify) | 665 | — | Long video → social clips: finds the funny moments, cuts, reframes to 9:16. |
| [claude-shorts](https://github.com/AgriciDaniel/claude-shorts) | 407 | SAFE | Longform → shortform with Remotion-rendered animated captions. |
| [papercut-explainer](https://github.com/0xS4N4TG/papercut-explainer) | 230 | SAFE | Vertical cut-paper explainer reels: 9 skills + a Remotion library. |
| [mrpaidsocial-video-editor-agent](https://github.com/mrpaidsocial/mrpaidsocial-video-editor-agent) | 170 | SAFE | Style-clones a reference reel, then builds a branded motion package. |
| [heditor](https://github.com/pycodebr/heditor) | 117 | SAFE | Creative vertical editing for agents across four harnesses. |
| [invokard-studio](https://github.com/Octonove/invokard-studio) | 3 | — | Reels that look edited, from a single SKILL.md. |
| [viral-video-edit-skills](https://github.com/BusyBee3333/viral-video-edit-skills) | 5 | SAFE | Beat-synced, effect-integrated short-form music edits. |
| [video-agent-skills](https://github.com/Melvynx/video-agent-skills) | 167 | — | Script, research and edit short-form — markdown-only skills. |
| [ecommerce-video-skills](https://github.com/xianyu110/ecommerce-video-skills) | 140 | — | 12 ecommerce skills: 3-second hook, selling storyboard, edge-tts, ffmpeg, Douyin/TikTok Shop export. |
| [claude-editing-skills](https://github.com/artemnovitckii/claude-editing-skills) | 81 | SAFE | Editing skills aimed at reels workflows. |
---

## 6. Explainers and education

Topic in, narrated explainer out. The strongest category in the whole ecosystem — 92 repos.

| Skill (repo) | ★ | Grade | What it does |
|---|---:|---|---|
| [explainroo](https://github.com/vincentsch/explainroo) | 1.3k | SAFE | Won the 16-skill bake-off: brief → finished film with sound in 2.0 minutes. |
| [vox-director](https://github.com/Alisa0808/vox-director) | 2.9k | SAFE | Vox-style paper-collage explainer/ad, automated end to end. |
| [manim_skill](https://github.com/adithya-s-k/manim_skill) | 1.3k | SAFE | Manim skills for 3Blue1Brown-style mathematical animation. |
| [cinematic-skill](https://github.com/Moh4696/cinematic-skill) | 597 | SAFE | Narrated cinematic films built from code: one continuous camera over photos and maps. |
| [khan-explainer](https://github.com/haiderfarooq3/khan-explainer) | 161 | SAFE | Khan Academy style: a hand draws while a voice explains. Local, no API. |
| [paper-reel](https://github.com/haiderfarooq3/paper-reel) | 141 | SAFE | Faceless 9:16 cut-paper explainer reels, voice-timed with word captions. |
| [MathLens](https://github.com/shuyicc/MathLens) | 350 | SAFE | Paste a maths problem → analysis, visual explanation, voice, Manim video. |
| [mortiflix-oss](https://github.com/GTKottman/mortiflix-oss) | 703 | SAFE | Motion design studio on your machine, step-by-step approval. |
| [what-if-animation](https://github.com/kelano86/what-if-animation) | 358 | SAFE | One topic line → finished 15-25s 'What if' animation. Runs on a free model. |
| [wallstreet-explainer](https://github.com/HeyChengC/wallstreet-explainer) | 719 | SAFE | Wall Street style finance/tech explainer shorts. |
| [vox-ai-motion-graphics-generator](https://github.com/Anil-matcha/vox-ai-motion-graphics-generator) | 354 | — | Topic → Vox paper-collage motion-graphics video. |
| [anything2explainer](https://github.com/Vincentwei1021/anything2explainer) | 3.4k | — | Any topic → narrated black-canvas explainer. |
| [video-talkcraft](https://github.com/Vincentwei1021/video-talkcraft) | 2.4k | — | Voiceover-driven explainers, run like a motion-design studio. |
| [video-shotcraft](https://github.com/Vincentwei1021/video-shotcraft) | 20.5k | — | Cinematic, editable product promos with 124 shot recipes (Remotion). |
| [video-spec-builder](https://github.com/feicaiclub/video-spec-builder) | 1.1k | — | Forces your idea into a second-accurate storyboard spec, then renders with HyperFrames. |
| [skill-video-studio](https://github.com/aaitor/skill-video-studio) | 397 | SAFE | Product videos with real browser capture, branded composition, local mastering. |
| [take-one](https://github.com/talsiach/take-one) | 298 | SAFE | One line → launch video, ad or music video: idea, script, visuals, voice. |
| [research-explainer-skill](https://github.com/sepi2p/research-explainer-skill) | 9 | CAUTION | 3Blue1Brown-style research explainers (CAUTION grade). |
---

## 7. Film, story and hand-drawn animation — the Opus 5.5 style skills

These are the ones built *for* Claude Opus 5.5 in Claude Code, and the ones that produce a look nothing else does.

| Skill (repo) | ★ | Grade | What it does |
|---|---:|---|---|
| [lemo-opuscar](https://github.com/lemomo-ai/lemo-opuscar) | 17.1k | SAFE | 99 ready film styles + your own. Each style is a prompt plus a demo film made entirely in code. 17.1k stars, made with Opus 5.5. |
| [huashu-art-motion](https://github.com/alchaincyf/huashu-art-motion) | 7.0k | SAFE | 35 art styles, 9 narration grammars — code-drawn artistic animation. |
| [ClaudeAnimationBase](https://github.com/JohnHeibel/ClaudeAnimationBase) | 3.0k | SAFE | Hand-painted cartoon starter: p5.js + p5.brush, Clawd character, 31 acted emotions. |
| [story-to-handdrawn-video](https://github.com/gnipbao/story-to-handdrawn-video) | 2.5k | SAFE | Story copy or ordered images → hand-drawn diary-comic animation. |
| [reelmimic](https://github.com/edenfunf/reelmimic) | 2.0k | SAFE | Show it a video you love; get a new video in the same style, via an agent crew. |
| [opus-video-skills](https://github.com/tuzhechen2005/opus-video-skills) | 512 | SAFE | Video-making skills written for Claude Opus 5.5 — every frame and note generated in code. |
| [xilo-opus-video](https://github.com/Kianzzz/xilo-opus-video) | 408 | SAFE | Opus 5.5 coded video: three options with previews, then frame-by-frame render. |
| [drama-skills](https://github.com/zenstory-ai/drama-skills) | 4.3k | — | Short-drama pipeline: novel → script, character sheets, storyboards, image/video prompts. |
| [claude-animation-skill](https://github.com/buildwithhanif/claude-animation-skill) | 160 | SAFE | Hand-drawn 2D animation as code: detail bible, rig, brush pen, frame matching. |
| [awesome-short-drama-skills](https://github.com/UnderleveledBuilder/awesome-short-drama-skills) | 2.4k | — | Index of short-drama (短剧) skill packs. |
| [PDoomVideo](https://github.com/JohnHeibel/PDoomVideo) | 3.0k | SAFE | The actual Opus 5.5 music-video source — reference, not a skill. |
| [awesome-claude-video](https://github.com/opusvideo/awesome-claude-video) | 250 | — | Videos people made with Opus 5.5, with the original posts. |
| [awesome-opus-5-5-prompts](https://github.com/TripoGrowthLab/awesome-opus-5-5-prompts) | 105 | — | Opus 5.5 prompts for 3D scenes, games, simulations. |
| [huashu-motion](https://github.com/alchaincyf/huashu-motion) | 2.8k | — | Commercial-grade launch films by your coding agent — composes music, edits by pointing at the frame. |
---

## 8. Avatars, UGC and talking heads

A face on screen without a camera.

| Skill (repo) | ★ | Grade | What it does |
|---|---:|---|---|
| [lanshu-create-ai-presenter-video](https://github.com/cclank/lanshu-create-ai-presenter-video) | 3.0k | SAFE | Provider-neutral skill for verified AI presenter videos from script + avatar. |
| [skills](https://github.com/heygen-com/skills) | 550 | SAFE | HeyGen's own skills: avatar creation and v3 Video Agent production. |
| [digital-human-koubo](https://github.com/andyhuo520/digital-human-koubo) | 2.0k | — | One photo → talking-head video, 5 editing styles, 48 creator scripts. |
| [higgsfield-claude-skills](https://github.com/AKCodez/higgsfield-claude-skills) | 493 | — | 19 skills for Higgsfield: image generation, Seedance 2.0 video, full UGC ads. |
| [higgsfield-seedance2-jineng](https://github.com/beshuaxian/higgsfield-seedance2-jineng) | 1.0k | — | 15 prompt skills for Seedance 2.0: cinematic, 3D CGI, anime, e-commerce. |
| [avatar-mix](https://github.com/Upload-Post/avatar-mix) | 138 | SAFE | HeyGen avatar + HyperFrames backgrounds + music, 16:9 and 9:16. |
| [lipnardo](https://github.com/AgriciDaniel/lipnardo) | 25 | SAFE | HeyGen avatar generation: batch, templates, translation, photo avatars. |
| [talking-avatar-video-skill](https://github.com/beatra-ai/talking-avatar-video-skill) | 5 | SAFE | Talking avatar skill across five harnesses. |
| [avatar-skills](https://github.com/puntorigen/avatar-skills) | 6 | SAFE | Cloud skills for avatar talking-head videos and reels. |
---

## 9. Music, audio and voice

Beat-grid analysis, lyric MVs, voiceover, podcast and transcription.

| Skill (repo) | ★ | Grade | What it does |
|---|---:|---|---|
| [vocaloid-style-mv-pipeline](https://github.com/EGSECDA/vocaloid-style-mv-pipeline) | 280 | SAFE | Deterministic vocaloid-style hand-drawn lyric MV production pipeline. |
| [claude-mv-skill](https://github.com/Joker-chichi/claude-mv-skill) | 234 | SAFE | Hand-painted animation + lyric music videos. |
| [music-mv](https://github.com/Win-Hao/music-mv) | 147 | SAFE | Understand the song → pick art style → characters → storyboard → film. Every frame is code. |
| [claude-music-video](https://github.com/TheMarco/claude-music-video) | 12 | SAFE | Complete MVs from a song: beat-grid analysis, archive footage, rendering. |
| [dancing-notes](https://github.com/SyanChen7/dancing-notes) | 27 | SAFE | Remotion music-visualisation skill. |
| [paint-mv-skills](https://github.com/lintsinghua/paint-mv-skills) | 72 | SAFE | Song + lyrics → hand-painted watercolour MV. |
| [music-mv-studio](https://github.com/chenqianshinian/music-mv-studio) | 9 | SAFE | Vertical MV with a director method, pixel-level QC and 41 documented pitfalls. |
| [video-podcast-maker](https://github.com/Agents365-ai/video-podcast-maker) | 1.7k | — | Topic → 4K narrated video podcast: research, script, Remotion, multilingual TTS, subtitles. |
| [audio-transcriber](https://github.com/zxkane/audio-transcriber) | 12 | — | Multi-speaker podcast/meeting transcription (FunASR, Paraformer/SenseVoice). |
| [ai-podcast-voiceover-skill](https://github.com/beatra-ai/ai-podcast-voiceover-skill) | 7 | — | Podcast voiceover generation skill. |
| [ai-voiceover-generator-skill](https://github.com/beatra-ai/ai-voiceover-generator-skill) | 6 | — | Voiceover generator skill for any script. |
| [bibigpt-skill](https://github.com/JimmyLv/bibigpt-skill) | 141 | — | Summarises any YouTube/Bilibili video or podcast into notes. |
---

## 10. Script, packaging, thumbnails, channel growth

The part that decides whether the edit gets watched at all.

| Skill (repo) | ★ | Grade | What it does |
|---|---:|---|---|
| [screenwriting-skills](https://github.com/jtydhr88/screenwriting-skills) | 2.1k | SAFE | Professional screenwriting, TV writing and dramaturgy skills. |
| [youtube-agent-skill](https://github.com/Jakeschincariol/youtube-agent-skill) | 6.2k | — | 11 skills that run a channel: 21 hook formulas with scoring, packaging, retention analysis. |
| [master-skills](https://github.com/Jakeschincariol/master-skills) | 181 | — | Three master skills: edit your videos, make them go viral, build anything. |
| [claude-youtube](https://github.com/AgriciDaniel/claude-youtube) | 785 | — | Channel audits, video SEO, retention scripts, thumbnails, content strategy. |
| [youtube-skills](https://github.com/sergebulaev/youtube-skills) | 100 | — | High-CTR titles, SEO descriptions, Shorts marketing. |
| [youtube-research-skills](https://github.com/TubeLabHQ/youtube-research-skills) | 100 | — | Outlier-video mining, niche validation, competitor research. |
| [youtube-seo-skills](https://github.com/deeployCO/youtube-seo-skills) | 22 | — | Eight SEO skills + helper scripts: audit and optimise. |
| [thumbnail-engine](https://github.com/Samin12/thumbnail-engine) | 8 | — | Thumbnail generator with 4 variants via Higgsfield Nano Banana Pro. |
| [ez-thumb](https://github.com/charlesdove977/ez-thumb) | 7 | — | Thumbnail + title packaging trained on your own channel. |
| [cutlist](https://github.com/itsryanlenk/cutlist) | 6 | — | Long video + captions → clip plan, every title/description, one thumbnail. |
| [videoanalyzer](https://github.com/Mharis-code/videoanalyzer) | 19 | — | Watches any social video and reverse-engineers it into a structured brief. |
| [create-viral-content](https://github.com/aaaronmiller/create-viral-content) | 87 | — | Hooks, titles, thumbnails, platform rules — reads as human. |
| [ai-shortfilm-prompts](https://github.com/jnMetaCode/ai-shortfilm-prompts) | 540 | — | Idea → cinematic, model-ready prompts for Sora / Kling / Veo / Seedance. |
| [storytelling-skills](https://github.com/yaxeen/storytelling-skills) | 28 | — | Seven skills applying six psychology storytelling levers to short-form. |
| [laoxu-video-script](https://github.com/chenmisss/laoxu-video-script) | 14 | SAFE | Chinese account-launch methodology: positioning, topics, 112 title templates. |
| [video-shot-analysis-feishu](https://github.com/wocha-xiaoli/video-shot-analysis-feishu) | 48 | — | Shot-by-shot teardown of any video: frames, per-shot analysis, reverse storyboard. |
| [claude-skills](https://github.com/jianshuo/claude-skills) | 142 | — | 13 video-production skills: transcribe / translate / dub / multicam / subtitles / reframe. |
| [content-vault](https://github.com/timscheuerai/content-vault) | 47 | — | 14 skills + Notion template that run a whole content engine across LinkedIn / X / YouTube. |
---

## 11. Content ops, social and marketing skills

Distribution: strategy, calendars, copy, repurposing, publishing.

| Skill (repo) | ★ | Grade | What it does |
|---|---:|---|---|
| [social-media-skills](https://github.com/blacktwist/social-media-skills) | 661 | — | Strategy and writing: audience context, calendars, hooks, threads, carousels, repurposing. |
| [head-of-content](https://github.com/bradautomates/head-of-content) | 322 | — | Content research and marketing for SMBs. |
| [social-ai-team](https://github.com/stevenflanagan1/social-ai-team) | 279 | — | A complete AI social team: brand setup, content, scheduling. |
| [marketingskills](https://github.com/coreyhaines31/marketingskills) | 60.8k | — | 60.8k stars. CRO, copywriting, SEO, analytics, growth engineering. |
| [seo-skills](https://github.com/Illyism/seo-skills) | 1.3k | — | 30 SEO skills: technical SEO, content, local, AI-search. |
| [content-pipeline](https://github.com/OrangeViolin/content-pipeline) | 219 | — | One prompt → research, draft, layout, cover, multi-platform adaptation, publishing. |
| [agent-skills](https://github.com/typefully/agent-skills) | 65 | — | Draft and schedule posts to X, LinkedIn, Threads, Bluesky, Mastodon. |
| [autopunk-media-skills](https://github.com/ur-grue/autopunk-media-skills) | 46 | — | 400+ skills and 9 agents for journalists, producers, podcasters. |
| [awesome-ai-media-skills](https://github.com/JuneYaooo/awesome-ai-media-skills) | 10 | — | Index of video-gen MCPs, social MCPs and content skills with A–C grades. |
---

## 12. Taste and design — the layer that stops it looking AI-made

Install at least one of these before you judge any render.

| Skill (repo) | ★ | Grade | What it does |
|---|---:|---|---|
| [hallmark](https://github.com/Nutlope/hallmark) | 56.1k | — | The anti-AI-slop design skill (56k). Typography, spacing, restraint. |
| [huashu-design](https://github.com/alchaincyf/huashu-design) | 29.6k | — | One line → deliverable design: web/app prototype, editable PPTX, animation, infographic. |
| [awesome-claude-design](https://github.com/rohitg00/awesome-claude-design) | 1.2k | — | DESIGN.md prompts by aesthetic family, remix recipes, video teardowns. |
| [baoyu-skills](https://github.com/JimLiu/baoyu-skills) | 27.6k | — | Xiaohongshu cards, infographics (21 layouts × 21 styles), SVG diagrams. |
| [claude-editing-skills](https://github.com/pihu26112005/claude-editing-skills) | 17 | — | Animated captions, titles and frames as a design system. |
| [guizang-product-video-skill](https://github.com/op7418/guizang-product-video-skill) | 947 | SAFE | Product films that reuse your real components and design language. |
---

## The stack I would install today

Curated for one person producing client work (xin Agency) — not everything, the ten that cover the whole job. All SAFE-graded. Install order matters: engine first, then scissors, then look.

| # | Skill | Why this one |
|---:|---|---|
| 1 | [remotion-dev/skills](https://github.com/remotion-dev/skills) | The engine. Most reliable render path tested (4.5 min), 7.3k stars, official. |
| 2 | [kajisho5/ffmpeg-skill](https://github.com/kajisho5/ffmpeg-skill) | 42 FFmpeg tools + MCP. Everything downstream calls it. Install second. |
| 3 | [bangtutorial/bang-motion](https://github.com/bangtutorial/bang-motion) | Browser motion graphics: openers, bumpers, kinetic type, 5 explainer styles. The "motion" skill that actually ships. |
| 4 | [charlie947/motion-graphics-skills](https://github.com/charlie947/motion-graphics-skills) | 13 launch-grade motion skills, every frame code. Your product-launch workhorse. |
| 5 | [echris6/motion-video-kit](https://github.com/echris6/motion-video-kit) | Same job as #4 but with an independent critic loop — the best-looking output in the bake-off. Slow (~22 min); use it for hero films only. |
| 6 | [vincentsch/explainroo](https://github.com/vincentsch/explainroo) | Fastest finished film with sound (2 min). Client explainers and demos. |
| 7 | [appariciojunior/video-editor-skills](https://github.com/appariciojunior/video-editor-skills) | First-pass editing in DaVinci: transcript cuts, vlog pacing. |
| 8 | [lordhoell/davinci-resolve-mcp](https://github.com/lordhoell/davinci-resolve-mcp) | 440+ Resolve API calls. Once this is in, Resolve is your renderer instead of Remotion. |
| 9 | [nateherkai/herk-edit-kit](https://github.com/nateherkai/herk-edit-kit) | 15 skills for reels / Shorts — the volume work. |
| 10 | [Jakeschincariol/youtube-agent-skill](https://github.com/Jakeschincariol/youtube-agent-skill) | Packaging: hooks with scoring, titles, retention. Decides if anyone watches the edit. |
| 11 | [lemomo-ai/lemo-opuscar](https://github.com/lemomo-ai/lemo-opuscar) | 99 code-made film styles, built with Opus 5.5. The look library. |
| 12 | [Nutlope/hallmark](https://github.com/Nutlope/hallmark) | Anti-AI-slop design skill. Install before judging any render. |

`claude_skills_install.sh` (same folder) installs them:

```bash
bash claude_skills_install.sh            # dry run: shows what it would place
bash claude_skills_install.sh --install  # clones, finds every SKILL.md, copies into ~/.claude/skills
```

---

## Security notes

The grader flags 18 of the 515 as **CAUTION** — not proven malicious, but they ship scripts that need reading before you run them. Among the ones big enough to tempt you:

| Repo | ★ | Why flagged |
|---|---:|---|
| [OpenMontageInc/OpenMontage](https://github.com/OpenMontageInc/OpenMontage) | 80.9k | Huge surface: 100+ tools and 700+ agent skills, many shell-outs. Read before running. |
| [howseen-ai/claude-motion-design](https://github.com/howseen-ai/claude-motion-design) | 837 | Playwright + ffmpeg pipeline with broad file access. |
| [wshuyi/remotion-video-skill](https://github.com/wshuyi/remotion-video-skill) | 478 | Unpinned install scripts. |
| [YKLovePython/halfsize](https://github.com/YKLovePython/halfsize) | 107 | Re-encodes in place; back up first. |

497 are graded safe. Licences: 346 MIT, 123 no declared licence (treat as all-rights-reserved — fine to use locally, not to redistribute), 32 Apache-2.0, 11 AGPL-3.0 (AGPL matters if you ship a hosted service on top).

---

## Honest caveats

- **The ecosystem is Chinese-first.** More than half the strongest skills have Chinese-only docs. I translated the ones in this document; the repos themselves do not. Skills labelled 短剧 / 口播 / 拉片 / 分镜 are short-drama / talking-head / shot-teardown / storyboard.
- **Star counts are inflated by novelty.** 85k stars on hyperframes is real but it is also the base everyone else builds on. Judge by the bake-off timings, not stars.
- **"Editable" usually means "exported as a project file",** not "opens perfectly in Premiere". Test one export before promising a client a handoff.
- **Model-specific skills age fast.** Anything labelled "for Opus 5.5" was tuned for it; it still works on other models but degrades.
- **No skill replaces an editor.** They get you to a first cut fast. The last 20% — pacing, sound, colour — is still you.
