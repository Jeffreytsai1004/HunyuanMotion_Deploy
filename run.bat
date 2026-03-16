@CALL "%~dp0micromamba" shell init --shell cmd.exe --root-prefix "%~dp0\"
@CALL condabin\micromamba.bat activate HY-Motion-1.0

@CALL set GDOWN_CACHE=cache\gdown
@CALL set TORCH_HOME=cache\torch
@CALL set HF_HOME=cache\huggingface
@CALL set PYTHONDONTWRITEBYTECODE=1
@CALL set CUDA_HOME=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.1

@CALL cd HY-Motion-1.0/
@CALL python gradio_app.py
@CALL PAUSE
