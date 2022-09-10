
# kOps Releases & Versioning

kOps intends to be backward compatible.  It is always recommended using the
latest version of kOps with whatever version of Kubernetes you are using.  We suggest
kOps users run one of the [3 minor versions](https://kubernetes.io/releases/version-skew-policy/#supported-versions) Kubernetes is supporting however we
do our best to support previous releases for some period.

kOps does not, however, support Kubernetes releases that have either a greater major
release number or greater minor release number than it.
(The numbers before the first and second dots are the major and minor release numbers, respectively.)
For example, kOps 1.20.0 does not support Kubernetes 1.21.0, but does
support Kubernetes 1.20.5, 1.19.2, and several previous Kubernetes versions.

## Compatibility Matrix

| kOps version  | k8s 1.19.x | k8s 1.20.x | k8s 1.21.x | k8s 1.22.x | k8s 1.23.x |
|---------------|------------|------------|------------|------------|------------|
| 1.23.x        | ✔          | ✔          | ✔          | ✔          | ✔          |

Use the latest version of kOps for all releases of Kubernetes, with the caveat
that higher versions of Kubernetes are not _officially_ supported by kOps.
Releases which are ~~crossed out~~ _should_ work, but are unlikely to get security or other fixes.
We suggest they be upgraded soon.

## Release Schedule

This project does not follow the Kubernetes release schedule.