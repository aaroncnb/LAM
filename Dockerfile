FROM pytorch/pytorch:2.3.0-cuda12.1-cudnn8-devel

USER root

ARG DEBIAN_FRONTEND=noninteractive

LABEL github_repo="github.com/aaroncnb/LAM.git"

RUN pip install torchvision==0.18.0 torchaudio==2.3.0 --index-url https://download.pytorch.org/whl/cu121 \
&& pip install -U xformers==0.0.26.post1 --index-url https://download.pytorch.org/whl/cu121

WORKDIR /workspace

RUN git clone https://github.com/aaroncnb/LAM.git \
&& cd LAM \
&& pip install -r requirements.txt

RUN cd external/landmark_detection/FaceBoxesV2/utils/ \
&& sh make.sh \
&& cd ../../../../

ENV SHELL=/bin/bash

VOLUME /root/.cache/huggingface/hub/


EXPOSE 7868

WORKDIR /workspace/LAM





