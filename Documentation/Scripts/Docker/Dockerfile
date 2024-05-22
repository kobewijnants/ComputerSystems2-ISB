############################
# @author Elias De Hondt   #
# @see https://eliasdh.com #
# @since 24/04/2024        #
############################

# Use the IIS image
FROM mcr.microsoft.com/windows/servercore/iis

LABEL author="Elias De Hondt <elias.dehondt@student.kdg.be>" \
      description="This is a Dockerfile to create a ISS server" \
      version="1.0"

# Expose port 80
EXPOSE 80

# Make a Hello World page
RUN echo "Hello World - Windows IIS" > C:\inetpub\wwwroot\index.html