resource "kubernetes_namespace" "sherpa_app" {
  metadata {
    name = "sherpa-app"
  }
}

resource "random_password" "postgres_admin_password" {
  length = 16
  special = false
}

resource "random_password" "postgres_user_password" {
  length = 16
  special = false
}

resource "helm_release" "sherpa_pgsql" {
  name       = "sherpa-pgsql"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"
  namespace  = kubernetes_namespace.sherpa_app.metadata.0.name
  set {
    name  = "primary.persistence.size"
    value = "1Gi"
  }
  set {
    name  = "primary.persistence.storageClass"
    value = "civo-volume"
  }
  set {
    name  = "metrics.enabled"
    value = "true"
  }
  set {
    name = "global.postgresql..auth.enablePostgresUser"
    value = "true"
  }
  set {
    name  = "global.postgresql.auth.username"
    value = "sherpa_app"
  }
  set {
    name  = "global.postgresql.auth.database"
    value = "sherpa_app"
  }
  set {
    name  = "global.postgresql.auth.password"
    value = random_password.postgres_user_password.result
  }
  set {
    name  = "global.postgresql.auth.postgresPassword"
    value = random_password.postgres_admin_password.result
  }
}