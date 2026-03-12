@echo off
echo ========================================
echo Creating HY-Motion-1.0 environment...
echo ========================================
@CALL "%~dp0micromamba" create -n HY-Motion-1.0 python==3.11 git==2.41.0 git-lfs==3.2.0 -c pytorch -c conda-forge -r "%~dp0\" -y
if errorlevel 1 (
    echo Environment creation failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Initializing micromamba shell...
echo ========================================
@CALL "%~dp0micromamba" shell init --shell cmd.exe --root-prefix="%~dp0\"
if errorlevel 1 (
    echo Shell initialization failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Activating HY-Motion-1.0 environment...
echo ========================================
@CALL "%~dp0condabin\micromamba.bat" activate HY-Motion-1.0
if errorlevel 1 (
    echo Environment activation failed!
    pause
    exit /b 1
)
@CALL set GDOWN_CACHE=cache\gdown
@CALL set TORCH_HOME=cache\torch
@CALL set HF_HOME=cache\huggingface
@CALL set PYTHONDONTWRITEBYTECODE=1
@CALL set CUDA_HOME=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.1
echo.
echo ========================================
echo Installing PyTorch (CUDA 12.1)...
echo ========================================
@CALL pip install --force-reinstall torch==2.5.1+cu121 torchvision==0.20.1+cu121 torchaudio==2.5.1+cu121 --index-url https://download.pytorch.org/whl/cu121 --no-cache-dir
if errorlevel 1 (
    echo PyTorch installation failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Installing other dependencies...
echo ========================================
@CALL pip install -r requirements.txt
if errorlevel 1 (
    echo Dependency installation failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Cloning HY-Motion-1.0 repository...
echo ========================================
if not exist "HY-Motion-1.0" (
    @CALL git clone https://github.com/Tencent-Hunyuan/HY-Motion-1.0.git
    if errorlevel 1 (
        echo Repository cloning failed!
        pause
        exit /b 1
    )
) else (
    echo HY-Motion-1.0 directory already exists, skipping clone
)

@CALL cd HY-Motion-1.0

echo.
echo ========================================
echo Creating cache directories...
echo ========================================
if not exist "cache\gdown" mkdir cache\gdown
if not exist "cache\torch" mkdir cache\torch
if not exist "cache\huggingface" mkdir cache\huggingface

echo.
echo ========================================
echo Pulling Git LFS files...
echo ========================================
@CALL git lfs pull
if errorlevel 1 (
    echo Git LFS pull failed, but continuing installation...
)

echo.
echo ========================================
echo Downloading model files...
echo ========================================

echo Downloading HY-Motion-1.0 Standard version...
@CALL huggingface-cli download tencent/HY-Motion-1.0 --include "HY-Motion-1.0/*" --local-dir ckpts/tencent
if errorlevel 1 (
    echo Standard model download failed!
    pause
    exit /b 1
)

echo Downloading HY-Motion-1.0 Lite version...
@CALL huggingface-cli download tencent/HY-Motion-1.0 --include "HY-Motion-1.0-Lite/*" --local-dir ckpts/tencent
if errorlevel 1 (
    echo Lite model download failed!
    pause
    exit /b 1
)

echo Downloading CLIP Large model...
@CALL huggingface-cli download openai/clip-vit-large-patch14 --local-dir ckpts/clip-vit-large-patch14/
if errorlevel 1 (
    echo CLIP model download failed!
    pause
    exit /b 1
)

echo Downloading Qwen3-8B text encoder...
@CALL huggingface-cli download Qwen/Qwen3-8B --local-dir ckpts/Qwen3-8B
if errorlevel 1 (
    echo Qwen model download failed!
    pause
    exit /b 1
)

echo Downloading Text2MotionPrompter...
@CALL huggingface-cli download Text2MotionPrompter/Text2MotionPrompter --local-dir ckpts/Text2MotionPrompter
if errorlevel 1 (
    echo Text2MotionPrompter download failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo Installation complete! Launching application...
echo ========================================
@CALL python gradio_app.py
if errorlevel 1 (
    echo Application launch failed!
    pause
    exit /b 1
)

@CALL PAUSE
