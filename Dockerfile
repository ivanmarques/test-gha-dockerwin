FROM mcr.microsoft.com/windows/servercore:ltsc2022 as download

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV GPG_VERSION 2.3.4
ENV NODE_VERSION 16.15.1

RUN Invoke-WebRequest $('https://files.gpg4win.org/gpg4win-vanilla-{0}.exe' -f $env:GPG_VERSION) -OutFile 'gpg4win.exe' -UseBasicParsing ; \
    Start-Process .\gpg4win.exe -ArgumentList '/S' -NoNewWindow -Wait


RUN Invoke-WebRequest $('https://nodejs.org/dist/v{0}/node-v{0}-win-x64.zip' -f $env:NODE_VERSION) -OutFile 'node.zip' -UseBasicParsing ; \
    Expand-Archive node.zip -DestinationPath C:\ ; \
    Rename-Item -Path $('C:\node-v{0}-win-x64' -f $env:NODE_VERSION) -NewName 'C:\nodejs'


ENV NPM_CONFIG_LOGLEVEL info

RUN $env:PATH = 'C:\nodejs;{0}' -f $env:PATH ; \
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

CMD [ "node.exe" ]