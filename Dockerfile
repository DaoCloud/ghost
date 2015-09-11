FROM ghost:latest

ADD adapter.sh /opt/adapter.sh
ADD config.js /opt/config.js
RUN chmod +x /opt/adapter.sh

ENTRYPOINT ["/opt/adapter.sh", "/entrypoint.sh"]
CMD ["npm", "start", "--production"]