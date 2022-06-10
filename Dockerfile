FROM chocolatey/choco:latest-windows

RUN choco install nodejs-lts -fy
RUN choco install python --version=3.9.0 -fy

ENTRYPOINT ["node", "-e" "console.log('hello from node')"]