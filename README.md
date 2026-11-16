# Claude editing skills
**171 GitHub repos, 174 graded skills, that turn Claude Code into a video / motion / editing / content studio — with an installer that puts them where Claude Code actually reads skills.**
Curated and verified 2026-11-17. Every repo resolved live through the GitHub API. Security grades come from [Agent Skills Hub](https://agentskillshub.top/best/claude-video-skills/), the only index that reads each repo and runs 16 of them end to end.
---
## Tell Claude to install it
Paste this into Claude Code:
```text
Clone https://github.com/riuxin/Claude-editing-skills.git, read INSTALL.md, then run
bash scripts/install.sh --install  (that is repos-min.txt: 5 skills).
Verify each entry has a SKILL.md, then tell me the context cost from /skill-doctor.
Do not run --core or --all in this pass.
```
By hand:
```bash
git clone https://github.com/riuxin/Claude-editing-skills.git
cd Claude-editing-skills

bash scripts/install.sh                      # dry run, repos-min.txt (5 skills)
bash scripts/install.sh --install            # install those 5
bash scripts/install.sh --install --core     # 72 skills — heavy, see the budget below
bash scripts/install.sh --install --all      # 300+ skills — do not do this blindly
```
---
## Three tiers, with the real numbers
Measured by running the installer against each list on a clean target, not estimated. Works on Windows (Git Bash), macOS and Linux.
| Tier | File | Repos | Individual skills | When |
|---|---|---:|---:|---|
| Minimal | `repos-min.txt` | 5 | **5** | Default. Covers edit, motion, explainer, NLE, taste. |
| Core | `repos-core.txt` | 12 | **74** | When you are doing client video work weekly and accept the context cost. |
| Full | `repos.txt` | 171 | 300+ | Reference only. Add repos one at a time from it. |
**74 skills is not a starter pack.** Every loaded skill adds to every turn whether it fires or not. The core tier exists because the big motion and editing repos happen to ship 11–15 skills each — useful, but they should be a deliberate second step, measured with `/skill-doctor`.
### Minimal tier (5 skills)
| Repo | Skills | Why |
|---|---:|---|
| [kajisho5/ffmpeg-skill](https://github.com/kajisho5/ffmpeg-skill) | 1 | Scissors: cut, join, reframe, speed, captions, loudness, platform exports. 42 tools, local, no API key. |
| [bangtutorial/bang-motion](https://github.com/bangtutorial/bang-motion) | 1 | Motion graphics: openers, promos, bumpers, kinetic typography, five explainer styles. |
| [vincentsch/explainroo](https://github.com/vincentsch/explainroo) | 1 | Brief to finished film with sound in ~2 minutes. Fastest in the 16-skill bake-off. |
| [lordhoell/davinci-resolve-mcp](https://github.com/lordhoell/davinci-resolve-mcp) | 1 | 440+ DaVinci Resolve API calls. Your renderer becomes Resolve instead of Remotion. |
| [Nutlope/hallmark](https://github.com/Nutlope/hallmark) | 1 | Anti-AI-slop design taste. Install before judging any render. |

### Core tier adds these 69 skills
| Repo | Skills | Why |
|---|---:|---|
| [remotion-dev/skills](https://github.com/remotion-dev/skills) | 13 | The render engine: official Remotion skills, most reliable path tested. |
| [charlie947/motion-graphics-skills](https://github.com/charlie947/motion-graphics-skills) | 15 | Launch-grade motion, every frame code, no After Effects. |
| [echris6/motion-video-kit](https://github.com/echris6/motion-video-kit) | 1 | Motion films with an independent critic loop — best-looking, ~22 min. |
| [appariciojunior/video-editor-skills](https://github.com/appariciojunior/video-editor-skills) | 12 | First-pass editing in DaVinci: transcript cuts, vlog pacing. |
| [nateherkai/herk-edit-kit](https://github.com/nateherkai/herk-edit-kit) | 15 | Reels and Shorts end to end: cuts, captions, style library, showreel. |
| [Jakeschincariol/youtube-agent-skill](https://github.com/Jakeschincariol/youtube-agent-skill) | 11 | Packaging: 21 hook formulas with scoring, titles, retention, SEO. |
| [lemomo-ai/lemo-opuscar](https://github.com/lemomo-ai/lemo-opuscar) | 2 | 99 code-made film styles, built with Opus 5.5. The look library. |

### Two repos, one skill name

`edit-video`, `captions` and the `hyperframes*` family each exist in more than one repo. The installer never overwrites and never drops: it keeps the first and installs the second as `<name>--<owner>-<repo>`, e.g. `edit-video--nateherkai-herk-edit-kit`. Every install writes a `.cc-source` marker inside the skill folder, so a re-run knows what came from where and skips cleanly.

Older installs made before markers existed cannot be attributed, so those names are skipped with a note. `--rename-conflicts` keeps both copies anyway.

---
## Contents
| File | What it is |
|---|---|
| `skills.json` | Machine-readable catalog: 174 entries with repo, URL, stars, security grade, licence, category and a one-line note. This is what an agent should read. |
| `repos-min.txt` | 5-repo minimal tier. The default. |
| `repos-core.txt` | 12-repo core tier (72 skills). |
| `repos.txt` | All 171 repos. |
| `scripts/install.sh` | Dry-run-by-default installer. Clones, finds every `SKILL.md`, copies real directories into `~/.claude/skills`. Idempotent. `--min` / `--core` / `--all`, `--rename-conflicts`, `--print-paths`. |
| `INSTALL.md` | Step-by-step, plugin-marketplace path, requirements per skill, how to back out. |
| `CLAUDE.md` | Guardrails Claude reads if it opens this repo. |
| `catalog.md` | The full written catalog — every entry, what it does, why it's here. |
| `claude_code_content_skills.csv` | Superset: 836 repos of video and content skills, sortable. |
---
## Everything, by job
### 1. All-in-one production systems — pick one as the base (12)
| Skill | Stars | Grade | What it does |
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

### 2. Motion graphics — the "motion" family (26)
| Skill | Stars | Grade | What it does |
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
| [kinetic-typography-skills](https://github.com/iart-ai/kinetic-typography-skills) | 29 | SAFE | Kinetic typography — type that moves on beat. |
| [YouTube-AI-Motion-Graphics](https://github.com/sirioberati/YouTube-AI-Motion-Graphics) | 213 | — | 74 animated HTML explainer boards: charts, diagrams, Venn, timelines. |
| [pixel2motion](https://github.com/nolangz/pixel2motion) | 2.7k | SAFE | Raster logo in → smooth SVG animation, HTML demo, GIF/MP4 out. |
| [data-animation-skills](https://github.com/iart-ai/data-animation-skills) | 19 | SAFE | Data-driven animation: numbers and charts that animate. |
| [javascript-animation-skills](https://github.com/iart-ai/javascript-animation-skills) | 67 | SAFE | JavaScript animation skills (p5/canvas patterns). |
| [map-motion](https://github.com/SpaceZephyr/map-motion) | 124 | SAFE | Map motion from real routes/borders/satellite: earth dive, journeys, flight paths. |
| [gif-factory](https://github.com/WoYun520/gif-factory) | 1.9k | SAFE | GIF factory: pixel art, mascots, clay characters, animated posters. |
| [anidoodle](https://github.com/alexgreensh/anidoodle) | 1.8k | SAFE | Art and animation as code: illustrations, loops, interactive web art. |
| [riso-windowseat](https://github.com/sevenevesai/riso-windowseat) | 319 | SAFE | Procedural risograph films, single-file HTML. |

### 3. Editing real footage — cuts, captions, reframe, effects (18)
| Skill | Stars | Grade | What it does |
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

### 4. Pro NLE bridges — DaVinci Resolve, Premiere Pro, After Effects (19)
| Skill | Stars | Grade | What it does |
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

### 5. Shorts, reels, faceless channels (13)
| Skill | Stars | Grade | What it does |
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

### 6. Explainers and education (18)
| Skill | Stars | Grade | What it does |
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

### 7. Film, story and hand-drawn animation — the Opus 5.5 style skills (14)
| Skill | Stars | Grade | What it does |
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

### 8. Avatars, UGC and talking heads (9)
| Skill | Stars | Grade | What it does |
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

### 9. Music, audio and voice (12)
| Skill | Stars | Grade | What it does |
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

### 10. Script, packaging, thumbnails, channel growth (18)
| Skill | Stars | Grade | What it does |
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

### 11. Content ops, social and marketing skills (9)
| Skill | Stars | Grade | What it does |
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

### 12. Taste and design — the layer that stops it looking AI-made (6)
| Skill | Stars | Grade | What it does |
|---|---:|---|---|
| [hallmark](https://github.com/Nutlope/hallmark) | 56.1k | — | The anti-AI-slop design skill (56k). Typography, spacing, restraint. |
| [huashu-design](https://github.com/alchaincyf/huashu-design) | 29.6k | — | One line → deliverable design: web/app prototype, editable PPTX, animation, infographic. |
| [awesome-claude-design](https://github.com/rohitg00/awesome-claude-design) | 1.2k | — | DESIGN.md prompts by aesthetic family, remix recipes, video teardowns. |
| [baoyu-skills](https://github.com/JimLiu/baoyu-skills) | 27.6k | — | Xiaohongshu cards, infographics (21 layouts × 21 styles), SVG diagrams. |
| [claude-editing-skills](https://github.com/pihu26112005/claude-editing-skills) | 17 | — | Animated captions, titles and frames as a design system. |
| [guizang-product-video-skill](https://github.com/op7418/guizang-product-video-skill) | 947 | SAFE | Product films that reuse your real components and design language. |

---
## Read this before installing everything
1. **Context is the real cost, not disk.** Loaded skills sit in every turn's context. Start at 5, run `/skill-doctor`, then add.
2. **A skill does not beat no skill by default.** On an identical 15-second brief, Claude Code with no skill produced a passing film in 4.4 minutes, and so did all 16 tested skills. What skills add is a look, a workflow, or footage handling. Use them for those.
3. **18 repos are graded CAUTION** — notably `OpenMontageInc/OpenMontage` (80.9k stars). They shell out and touch your filesystem broadly. Read before running.
4. **Licences:** most are MIT or Apache-2.0; about a quarter declare none. Local use is fine; redistributing output is your call and the repo's terms decide it.
5. **Nothing is vendored here.** This repo is a catalog plus an installer. It clones from each author's repository, so credit and updates stay with them.

## Sources

- [zhuyansen/awesome-claude-video-skills](https://github.com/zhuyansen/awesome-claude-video-skills) — 515 repos, read and security-graded, refreshed every 8 hours.
- [JuneYaooo/awesome-ai-media-skills](https://github.com/JuneYaooo/awesome-ai-media-skills) — video-gen MCPs, social MCPs, content skills, A–C grades.
- [opusvideo/awesome-claude-video](https://github.com/opusvideo/awesome-claude-video) — what people made with Opus 5.5.
- [rohitg00/awesome-claude-design](https://github.com/rohitg00/awesome-claude-design) — DESIGN.md prompts and video teardowns.
- GitHub search API for the non-video half: thumbnails, SEO, copywriting, social, audio, NLE bridges.
