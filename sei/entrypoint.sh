#!/usr/bin/env bash

# Atribuição dos parâmetros de configuração do SEI
if [ -f /opt/sei/config/ConfiguracaoSEI.php ] && [ ! -f /opt/sei/config/ConfiguracaoSEI.php~ ]; then
    mv /opt/sei/config/ConfiguracaoSEI.php /opt/sei/config/ConfiguracaoSEI.php~
fi

if [ ! -f /opt/sei/config/ConfiguracaoSEI.php ]; then
    cp /ConfiguracaoSEI.php /opt/sei/config/ConfiguracaoSEI.php
fi

# Atribuição dos parâmetros de configuração do SIP
if [ -f /opt/sip/config/ConfiguracaoSip.php ] && [ ! -f /opt/sip/config/ConfiguracaoSip.php~ ]; then
    mv /opt/sip/config/ConfiguracaoSip.php /opt/sip/config/ConfiguracaoSip.php~
fi

if [ ! -f /opt/sip/config/ConfiguracaoSip.php ]; then
    cp /ConfiguracaoSip.php /opt/sip/config/ConfiguracaoSip.php
fi

# Ajustes de permissões diversos para desenvolvimento do SEI
chmod +x /opt/sei/bin/wkhtmltopdf-amd64
chmod +x /opt/sei/bin/pdfboxmerge.jar
chown -R 777 /opt
chmod -R 777 /var/sei/arquivos
#chmod -R 777 /opt/sei/temp
#chmod -R 777 /opt/sip/temp

# Inicialização das rotinas de agendamento
/etc/init.d/rsyslog start
/etc/init.d/crond start

# Inicialização do Gearman e Supervisor, componentes para integração com Processo Eletrônico Nacional
/etc/init.d/gearmand start
/etc/init.d/supervisord start

# Inicialização do servidor web
/usr/sbin/httpd -DFOREGROUND
