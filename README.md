# Instalação do Tekton

Este guia fornece instruções para instalar o Tekton em seu cluster Kubernetes.

## Pré-requisitos

- Um cluster Kubernetes em funcionamento
- `kubectl` instalado e configurado para se comunicar com seu cluster

## Passos de instalação

1. Instale o Tekton Pipelines:

```bash
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
```

2. Instale o Tekton Triggers:

```bash
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/previous/v0.26.2/release.yaml
```

3. Instale os Tekton Interceptors:

```bash
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/previous/v0.26.2/interceptors.yaml
```

## Verificação da instalação

Após a execução dos comandos acima, você pode verificar se a instalação foi bem-sucedida executando:

```bash
kubectl get pods --namespace tekton-pipelines
```

Você deve ver vários pods em execução no namespace `tekton-pipelines`.

## Instalações opcionais (recomendadas)

Estas instalações são opcionais, mas podem ser muito úteis para trabalhar com o Tekton.

### Tekton Dashboard

O Tekton Dashboard fornece uma interface web para visualizar e gerenciar seus pipelines Tekton.

Para instalar o Tekton Dashboard:

```bash
kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml
```

### Task git-clone

A task git-clone é uma tarefa reutilizável que clona um repositório git. É frequentemente usada em pipelines Tekton.

Para instalar a task git-clone:

```bash
kubectl apply -f https://raw.githubusercontent.com/tektoncd/catalog/main/task/git-clone/0.7/git-clone.yaml -n tekton
```

Nota: Este comando instala a task no namespace `tekton`. Ajuste o namespace conforme necessário para o seu ambiente.

## Próximos passos

Após a instalação, você pode começar a criar e executar Tekton Tasks e Pipelines em seu cluster. Se você instalou o Dashboard, pode acessá-lo para visualizar seus recursos Tekton com o seguinte comando:

```bash
kubectl --namespace tekton-pipelines port-forward svc/tekton-dashboard 9097:9097
```

Consulte a [documentação oficial do Tekton](https://tekton.dev/docs/) para mais informações sobre como começar a usar o Tekton.

---------------------------------------------------------------------------------------------
** Comando para alteração do storageclass **

kubectl patch storageclass standard -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"false"}}}'

kubectl patch storageclass gold -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'






Depois de subir o código no github eu mudo para a branch main, atualizo ela e rodo aquele script que gera as imagens

Então, eu coloco a tag das versões nas imagens e dou um pull

Um com a tag e outro sem a tag para que a tag latest fique na versão mais atual mesmo