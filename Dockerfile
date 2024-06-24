FROM debian:latest

HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

EXPOSE 22
CMD ['/bin/echo', 'HELLO WORLD....']
