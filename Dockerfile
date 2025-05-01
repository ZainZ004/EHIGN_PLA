FROM pytorch/pytorch:1.12.1-cuda11.3-cudnn8-runtime

WORKDIR /app

COPY environment.yaml .
COPY requirements.txt .
RUN conda env create -f environment.yaml \
    && conda run -n enhign pip install backports.tarfile \
    && conda run -n enhign pip install -U setuptools \
    && conda run -n enhign pip install -r requirements.txt \
    && conda clean --all -f -y \
    && conda run -n enhign pip cache purge \
    && conda init bash \
    && echo "conda activate enhign" >> ~/.bashrc

COPY . /app/

EXPOSE 8888
ENTRYPOINT ["/opt/conda/envs/enhign/bin/jupyter", "lab", "--ip='0.0.0.0'", "--port=8889", "--no-browser", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]