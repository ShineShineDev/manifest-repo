{{/*
Expand the name of the chart.
*/}}
{{- define "pos-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
Truncate to 63 chars (Kubernetes DNS limit).
*/}}
{{- define "pos-api.fullname" -}}
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
Create chart label value.
*/}}
{{- define "pos-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "pos-api.labels" -}}
helm.sh/chart: {{ include "pos-api.chart" . }}
{{ include "pos-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "pos-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pos-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: {{ include "pos-api.name" . }}
{{- end }}

{{/*
ServiceAccount name.
*/}}
{{- define "pos-api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "pos-api.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
