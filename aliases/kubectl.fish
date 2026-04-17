# Kubectl abbreviations – mirrors the OMZ kubectl plugin.
# Compound aliases (e.g. kgpw, kgdw) are fully expanded since fish
# abbreviations do not re-expand recursively after the first substitution.

abbr --add k kubectl

# ── Apply ─────────────────────────────────────────────────────────────────────
abbr --add kaf 'kubectl apply -f'
abbr --add kapk 'kubectl apply -k'

# ── Config / Context ──────────────────────────────────────────────────────────
abbr --add kccc 'kubectl config current-context'
abbr --add kcdc 'kubectl config delete-context'
abbr --add kcgc 'kubectl config get-contexts'
abbr --add kcn 'kubectl config set-context --current --namespace'
abbr --add kcsc 'kubectl config set-context'
abbr --add kcuc 'kubectl config use-context'

# ── Copy ──────────────────────────────────────────────────────────────────────
abbr --add kcp 'kubectl cp'

# ── Delete ────────────────────────────────────────────────────────────────────
abbr --add kdel 'kubectl delete'
abbr --add kdelf 'kubectl delete -f'
abbr --add kdelk 'kubectl delete -k'
abbr --add kdelcj 'kubectl delete cronjob'
abbr --add kdelcm 'kubectl delete configmap'
abbr --add kdeld 'kubectl delete deployment'
abbr --add kdelds 'kubectl delete daemonset'
abbr --add kdeli 'kubectl delete ingress'
abbr --add kdelj 'kubectl delete job'
abbr --add kdelno 'kubectl delete node'
abbr --add kdelns 'kubectl delete namespace'
abbr --add kdelp 'kubectl delete pods'
abbr --add kdelpvc 'kubectl delete pvc'
abbr --add kdelsa 'kubectl delete sa'
abbr --add kdelsec 'kubectl delete secret'
abbr --add kdels 'kubectl delete svc'
abbr --add kdelss 'kubectl delete statefulset'

# ── Describe ──────────────────────────────────────────────────────────────────
abbr --add kdcj 'kubectl describe cronjob'
abbr --add kdcm 'kubectl describe configmap'
abbr --add kdd 'kubectl describe deployment'
abbr --add kdds 'kubectl describe daemonset'
abbr --add kdi 'kubectl describe ingress'
abbr --add kdj 'kubectl describe job'
abbr --add kdno 'kubectl describe node'
abbr --add kdns 'kubectl describe namespace'
abbr --add kdp 'kubectl describe pods'
abbr --add kdpvc 'kubectl describe pvc'
abbr --add kdrs 'kubectl describe replicaset'
abbr --add kdsa 'kubectl describe sa'
abbr --add kdsec 'kubectl describe secret'
abbr --add kds 'kubectl describe svc'
abbr --add kdss 'kubectl describe statefulset'

# ── Edit ──────────────────────────────────────────────────────────────────────
abbr --add kecj 'kubectl edit cronjob'
abbr --add kecm 'kubectl edit configmap'
abbr --add ked 'kubectl edit deployment'
abbr --add keds 'kubectl edit daemonset'
abbr --add kei 'kubectl edit ingress'
abbr --add kej 'kubectl edit job'
abbr --add keno 'kubectl edit node'
abbr --add kens 'kubectl edit namespace'
abbr --add kep 'kubectl edit pods'
abbr --add kepvc 'kubectl edit pvc'
abbr --add kers 'kubectl edit replicaset'
abbr --add kes 'kubectl edit svc'
abbr --add kess 'kubectl edit statefulset'

# ── Exec ──────────────────────────────────────────────────────────────────────
abbr --add keti 'kubectl exec -t -i'

# ── Get ───────────────────────────────────────────────────────────────────────
abbr --add kga 'kubectl get all'
abbr --add kgaa 'kubectl get all --all-namespaces'
abbr --add kca 'kubectl get all --all-namespaces'
abbr --add kgcj 'kubectl get cronjob'
abbr --add kgcm 'kubectl get configmaps'
abbr --add kgcma 'kubectl get configmaps --all-namespaces'
abbr --add kgd 'kubectl get deployment'
abbr --add kgda 'kubectl get deployment --all-namespaces'
abbr --add kgdw 'kubectl get deployment --watch'
abbr --add kgdwide 'kubectl get deployment -o wide'
abbr --add kgds 'kubectl get daemonset'
abbr --add kgdsa 'kubectl get daemonset --all-namespaces'
abbr --add kgdsw 'kubectl get daemonset --watch'
abbr --add kge 'kubectl get events --sort-by=".lastTimestamp"'
abbr --add kgew 'kubectl get events --sort-by=".lastTimestamp" --watch'
abbr --add kgi 'kubectl get ingress'
abbr --add kgia 'kubectl get ingress --all-namespaces'
abbr --add kgj 'kubectl get job'
abbr --add kgno 'kubectl get nodes'
abbr --add kgnosl 'kubectl get nodes --show-labels'
abbr --add kgns 'kubectl get namespaces'
abbr --add kgp 'kubectl get pods'
abbr --add kgpa 'kubectl get pods --all-namespaces'
abbr --add kgpall 'kubectl get pods --all-namespaces -o wide'
abbr --add kgpl 'kubectl get pods -l'
abbr --add kgpn 'kubectl get pods -n'
abbr --add kgpsl 'kubectl get pods --show-labels'
abbr --add kgpvc 'kubectl get pvc'
abbr --add kgpvca 'kubectl get pvc --all-namespaces'
abbr --add kgpvcw 'kubectl get pvc --watch'
abbr --add kgpw 'kubectl get pods --watch'
abbr --add kgpwide 'kubectl get pods -o wide'
abbr --add kgrs 'kubectl get replicaset'
abbr --add kgs 'kubectl get svc'
abbr --add kgsa 'kubectl get svc --all-namespaces'
abbr --add kgsec 'kubectl get secret'
abbr --add kgseca 'kubectl get secret --all-namespaces'
abbr --add kgss 'kubectl get statefulset'
abbr --add kgssa 'kubectl get statefulset --all-namespaces'
abbr --add kgssw 'kubectl get statefulset --watch'
abbr --add kgsswide 'kubectl get statefulset -o wide'
abbr --add kgsw 'kubectl get svc --watch'
abbr --add kgswide 'kubectl get svc -o wide'

# ── Logs ──────────────────────────────────────────────────────────────────────
abbr --add kl 'kubectl logs'
abbr --add klf 'kubectl logs -f'
abbr --add kl1h 'kubectl logs --since 1h'
abbr --add kl1m 'kubectl logs --since 1m'
abbr --add kl1s 'kubectl logs --since 1s'
abbr --add klf1h 'kubectl logs --since 1h -f'
abbr --add klf1m 'kubectl logs --since 1m -f'
abbr --add klf1s 'kubectl logs --since 1s -f'

# ── Port-forward ──────────────────────────────────────────────────────────────
abbr --add kpf 'kubectl port-forward'

# ── Rollout ───────────────────────────────────────────────────────────────────
abbr --add krh 'kubectl rollout history'
abbr --add krrd 'kubectl rollout restart deployment'
abbr --add krrss 'kubectl rollout restart statefulset'
abbr --add krsd 'kubectl rollout status deployment'
abbr --add krsss 'kubectl rollout status statefulset'
abbr --add kru 'kubectl rollout undo'

# ── Scale ─────────────────────────────────────────────────────────────────────
abbr --add ksd 'kubectl scale deployment'
abbr --add ksss 'kubectl scale statefulset'
