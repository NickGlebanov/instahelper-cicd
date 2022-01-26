# CI/CD for skillbox diploma

## Gitlab Community Edition
В качестве DevOps платформы для проекта используется Gitlab сервер. 
В качестве инфраструктуры используется vds от selectel. Для автоматизации инфраструктурных задач
написан скрипт на Python, т.к. отсутствует поддерживаемый провайдер для терраформ.
Для управления DNS ресурсами используется terraform, для конфигурирования сервера - ansible.

## Gitlab Runner

Для раннера реализована автоматизация terraform (aws) + ansible.

# Порядок установки

1. Запустить `create_server.py`
2. Выполнить плейбук `install_gitlab_ce.yml`
3. Выполнить terraform apply в папке `gitlab-ce/terraform`
4. Выполнить terraform apply в папке `gitlab-runner/terraform`
5. Выполнить плейбук `deploy_runners_playbook.yml`

__Для каждого задания требуется указать хосты и токены если они требуются__
Токен от vsd.selectel поместить в файл `token`