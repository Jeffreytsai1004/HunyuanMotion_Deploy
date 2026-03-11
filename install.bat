@CALL "%~dp0micromamba" create -n HY-Motion-1.0 python==3.10.14 git==2.41.0 git-lfs==3.2.0 -c pytorch -c conda-forge -r "%~dp0\" -y
@CALL "%~dp0micromamba" shell init --shell cmd.exe
@CALL condabin\micromamba.bat activate HY-Motion-1.0
@CALL set GDOWN_CACHE=cache\gdown
@CALL set TORCH_HOME=cache\torch
@CALL set HF_HOME=cache\huggingface
@CALL set PYTHONDONTWRITEBYTECODE=1
@CALL set CUDA_HOME=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.1
@CALL pip install --force-reinstall torch==2.5.1+cu121 torchvision==0.20.1+cu121 torchaudio==2.5.1+cu121 torchdiffeq --index-url https://download.pytorch.org/whl/cu121 --no-cache-dir
@CALL git clone https://github.com/Tencent-Hunyuan/HY-Motion-1.0.git
@CALL cd HY-Motion-1.0/
@CALL mkdir cache\gdown
@CALL mkdir cache\torch
@CALL mkdir cache\huggingface
@CALL git lfs pull
@CALL pip install -r requirements.txt
@REM Example for Standard version
@CALL huggingface-cli download tencent/HY-Motion-1.0 --include "HY-Motion-1.0/*" --local-dir ckpts/tencent
@REM Example for Lite version
@CALL huggingface-cli download tencent/HY-Motion-1.0 --include "HY-Motion-1.0-Lite/*" --local-dir ckpts/tencent
@REM CLIP Large
@CALL huggingface-cli download openai/clip-vit-large-patch14 --local-dir ckpts/clip-vit-large-patch14/
@REM Qwen Text Encoder
@CALL huggingface-cli download Qwen/Qwen3-8B --local-dir ckpts/Qwen3-8B
@REM Text2MotionPrompter
@CALL huggingface-cli download Text2MotionPrompter/Text2MotionPrompter --local-dir ckpts/Text2MotionPrompter
@REM Launch App
@CALL python gradio_app.py
@CALL PAUSE
