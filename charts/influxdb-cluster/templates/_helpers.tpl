{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "influxdb-cluster.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "influxdb-cluster.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "influxdb-cluster.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "influxdb-cluster.labels" -}}
helm.sh/chart: {{ include "influxdb-cluster.chart" . }}
{{ include "influxdb-cluster.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "influxdb-cluster.selectorLabels" -}}
app.kubernetes.io/name: {{ include "influxdb-cluster.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "influxdb-cluster.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "influxdb-cluster.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "influxdb-cluster.image" -}}
{{- $repoName := "chengshiwen/influxdb" -}}
{{- $tagName := (printf "%s-%s" .chart.AppVersion .podtype) -}}
{{- if .imageroot }}
{{- if .imageroot.repository -}}
{{- $repoName = .imageroot.repository -}}
{{- end -}}
{{- if .imageroot.tag -}}
{{- $tagName = printf "%s-%s" .imageroot.tag .podtype -}}
{{- end -}}
{{- end }}
{{- .podvals.image.repository | default $repoName }}:{{ $tagName }}
{{- end }}
