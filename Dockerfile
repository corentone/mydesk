FROM alpine

# Note: We could use scratch but it seems almost more painful than anything... At least alpine got a shell :)
# Seems worth the 5MB... :)
# https://blog.codeship.com/building-minimal-docker-containers-for-go-applications/

EXPOSE 8000
CMD ["/mydeskserver"]

COPY mydeskserver /mydeskserver