@CALL "%~dp0micromamba" shell init --shell cmd.exe --prefix "%~dp0\"
start cmd /k "%~dp0condabin\micromamba.bat" activate HY-Motion-1.0

@CALL set GDOWN_CACHE=cache\gdown
@CALL set TORCH_HOME=cache\torch
@CALL set HF_HOME=cache\huggingface
@CALL set PYTHONDONTWRITEBYTECODE=1
@CALL set CUDA_HOME=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.1