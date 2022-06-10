FROM chocolatey/choco:latest-linux

RUN choco install nodejs-lts -fy
RUN choco install python --version=3.9.0 -fy

RUN python --version
RUN node --version

RUN node -e "console.log('hello from node')"
RUN python -c "print('hello from python')"