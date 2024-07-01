# Deploy dynatrace operator
resource "helm_release" "dynatrace-operator" {
  namespace  = "dynatrace"
  name       = "dynatrace-operator"
  repository = "oci://public.ecr.aws/dynatrace"
  chart      = "dynatrace-operator"
  version    = var.dynatrace-operator-version
  atomic     = true
  create_namespace = true

  # https://github.com/Dynatrace/dynatrace-operator/blob/v1.1.1/config/helm/chart/default/values.yaml
  set {
    name  = "csidriver.enabled"
    value = local.dynatrace-operator-csi-driver
  }
}

#Secret
resource "kubectl_manifest" "dyna-secret" {
    yaml_body         = templatefile("${path.module}/manifest/secret.yaml", {
      apiToken        = var.dynatrace-apiToken
      dataIngestToken = var.dynatrace-dataIngestToken
      clusterName     = var.cluster-name
  })

  depends_on = [
    helm_release.dynatrace-operator
  ]
}

# Deploy Dynakube CR
resource "kubectl_manifest" "dynakube" {
    yaml_body     = templatefile("${path.module}/manifest/${var.dynatrace-deployment-mode}.yaml", {
      apiUrl      = var.dynatrace-api-url
      clusterName = var.cluster-name
      agGroup     = var.cluster-name
      oaHostGroup = var.cluster-name
  })

  depends_on = [
    helm_release.dynatrace-operator
  ]
}

