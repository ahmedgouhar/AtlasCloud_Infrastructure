# 🌍 Environments Configuration

This folder contains environment-specific Terraform variables.

---

## 📁 Structure

```
envs/
├── dev.tfvars
├── staging.tfvars
├── prod.tfvars
```

---

## 🚀 How to Deploy per Environment

### Dev

```bash
terraform apply -var-file="envs/dev.tfvars"
```

### Staging

```bash
terraform apply -var-file="envs/staging.tfvars"
```

### Production

```bash
terraform apply -var-file="envs/prod.tfvars"
```

---

## ⚙️ Environment Strategy

| Environment | Purpose                   |
| ----------- | ------------------------- |
| Dev         | Testing & development     |
| Staging     | Pre-production validation |
| Prod        | Live infrastructure       |

---

## 🔐 Best Practices

* Never hardcode secrets
* Use separate state files per environment
* Enable approval gate for production
* Use remote backend (S3 + DynamoDB)

---

## 🧠 Notes

* Each environment may have different:

  * instance sizes
  * scaling limits
  * CIDR ranges
