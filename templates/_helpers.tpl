{{/*
Expand the name of the chart.
*/}}
{{- define "watchedsky.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "watchedsky.fullname" -}}
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
{{- define "watchedsky.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "watchedsky.labels" -}}
helm.sh/chart: {{ include "watchedsky.chart" . }}
{{ include "watchedsky.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "watchedsky.selectorLabels" -}}
app.kubernetes.io/name: {{ include "watchedsky.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "watchedsky.coreLabels" -}}
helm.sh/chart: {{ include "watchedsky.chart" . }}
{{ include "watchedsky.coreSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "watchedsky.coreSelectorLabels" -}}
app.kubernetes.io/name: {{ include "watchedsky.name" . }}-core
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "watchedsky.frontendLabels" -}}
helm.sh/chart: {{ include "watchedsky.chart" . }}
{{ include "watchedsky.frontendSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "watchedsky.frontendSelectorLabels" -}}
app.kubernetes.io/name: {{ include "watchedsky.name" . }}-frontend
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "watchedsky.xrpcLabels" -}}
helm.sh/chart: {{ include "watchedsky.chart" . }}
{{ include "watchedsky.xrpcSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "watchedsky.xrpcSelectorLabels" -}}
app.kubernetes.io/name: {{ include "watchedsky.name" . }}-xrpc
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "watchedsky.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "watchedsky.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
