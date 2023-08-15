FROM louislam/uptime-kuma:latest

ARG PORT
ENV ROCKET_PORT ${PORT}

EXPOSE ${PORT}

CMD [ "./start.sh" ]
