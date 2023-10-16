{{/*
Expand the name of the chart.
*/}}
{{- define "snortids.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "snortids.namespace" -}}
{{- if contains .Release.Namespace "default" }}
{{- default "ovn-kubernetes" }}
{{- else }}
{{- .Release.Namespace | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}

{{- define "dbg.var_dump" -}}
{{- . | mustToPrettyJson | printf "\nThe JSON output of the dumped var is: \n%s" | fail }}
{{- end -}}

# get bd name, ex: blockdevice-xxx
{{- define "snortids.bd" -}}
{{- $bd_name := "" -}}
{{- range $index, $bd := (lookup "openebs.io/v1alpha1" "BlockDevice" .Release.Namespace "").items -}}
  {{- /* do something with each bd */ -}}
  {{- if not $bd_name -}}
  {{- $bd_name = $bd.metadata.name -}}
  {{- end -}}
  {{- /* template "dbg.var_dump" $bd */ -}}
{{- end -}}
{{- if not $bd_name -}}
{{- template "dbg.var_dump" "No bd found !!!" -}}
{{- else }}
{{- /* template "dbg.var_dump" $bd_name */ -}}
{{- printf $bd_name -}}
{{- end -}}
{{- end -}}

# get bd's node name
# index . 0 : namespace
# index . 1 : bd_name
{{- define "snortids_bd.node" -}}
{{- $node_name := (lookup "openebs.io/v1alpha1" "BlockDevice" (index . 0) (index . 1) ).spec.nodeAttributes.nodeName -}}
{{- if not $node_name -}}
{{- template "dbg.var_dump" "No nodename found !!!" -}}
{{- else }}
{{- /* template "dbg.var_dump" $node_name */ -}}
{{- printf $node_name -}}
{{- end -}}
{{- end -}}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "snortids.fullname" -}}
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
{{- define "snortids.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "snortids.labels" -}}
helm.sh/chart: {{ include "snortids.chart" . }}
{{ include "snortids.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "snortids.selectorLabels" -}}
app.kubernetes.io/name: {{ include "snortids.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "snortids.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "snortids.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
