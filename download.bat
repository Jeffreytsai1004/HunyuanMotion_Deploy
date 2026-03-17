@echo off

:: Init and activate environment
@CALL "%~dp0micromamba" shell init --shell cmd.exe --root-prefix "%~dp0\"
call "%~dp0condabin\micromamba.bat" activate HY-Motion-1.0

@CALL set GDOWN_CACHE=cache\gdown
@CALL set TORCH_HOME=cache\torch
@CALL set HF_HOME=cache\huggingface
@CALL set PYTHONDONTWRITEBYTECODE=1
@CALL set CUDA_HOME=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.1

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


cd HY-Motion-1.0

:: Download models
if not exist ckpts\tencent\HY-Motion-1.0 (
    echo Downloading HY-Motion-1.0 Standard version...
    @CALL huggingface-cli download tencent/HY-Motion-1.0 --include "HY-Motion-1.0/*" --local-dir ckpts/tencent
    if errorlevel 1 (
        echo Standard model download failed!
        pause
        exit /b 1
    )
) else (
    echo HY-Motion-1.0 Standard version already exists, skipping download.
)

if not exist ckpts\tencent\HY-Motion-1.0-Lite (
    echo Downloading HY-Motion-1.0 Lite version...
    @CALL huggingface-cli download tencent/HY-Motion-1.0 --include "HY-Motion-1.0-Lite/*" --local-dir ckpts/tencent
    if errorlevel 1 (
        echo Lite model download failed!
        pause
        exit /b 1
    )
) else (
    echo HY-Motion-1.0 Lite version already exists, skipping download.
)

if not exist ckpts\clip-vit-large-patch14 (
    echo Downloading CLIP Large model...
    @CALL huggingface-cli download openai/clip-vit-large-patch14 --local-dir ckpts/clip-vit-large-patch14/
    if errorlevel 1 (
        echo CLIP model download failed!
        pause
        exit /b 1
    )
) else (
    echo CLIP Large model already exists, skipping download.
)

if not exist ckpts\Qwen3-8B (
    echo Downloading Qwen3-8B text encoder...
    @CALL huggingface-cli download Qwen/Qwen3-8B --local-dir ckpts/Qwen3-8B
    if errorlevel 1 (
        echo Qwen model download failed!
        pause
        exit /b 1
    )
) else (
    echo Qwen3-8B text encoder already exists, skipping download.
)

if not exist ckpts\Text2MotionPrompter (
    echo Downloading Text2MotionPrompter...
    @CALL huggingface-cli download Text2MotionPrompter/Text2MotionPrompter --local-dir ckpts/Text2MotionPrompter
    if errorlevel 1 (
        echo Text2MotionPrompter download failed!
        pause
        exit /b 1
    )
) else (
    echo Text2MotionPrompter already exists, skipping download.
)

echo All models downloaded completed !
pause
