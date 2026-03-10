@CALL "%~dp0micromamba" shell init --shell cmd.exe --prefix "%~dp0\"
@CALL condabin\micromamba.bat activate HY-Motion-1.0
@CALL cd HY-Motion-1.0/
@CALL python gradio_app.py
@CALL PAUSE
