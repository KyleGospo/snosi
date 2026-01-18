# monorepo plan

```
                          base            <- stuff that makes debian + bootc
                            |
                -------------------------
                |                       |
              cayo*  (server stuff)   snow* (desktop/gnome)
                  |                     |
          ----------------------      ---------------------------
          [docker] [incus] [virt]     |                 |       |
                                      /snowspawn/       loaded*  snowfield* (surface)
                                      * nspawn version
                                      * for home bind
                                      * install anything

legend:
  * oci
  [sysext]
  /tar/ for nspawn
```

## Images

Images don't include kernel or modules, these get added with PROFILES

- base - everything that makes debian
- cayo - debian server
- cayo-bpo - cayo + packports kernel
- incus - sysext for base and above
- docker - sysext for base and above
- snow - gnome desktop
- snowloaded - snow + loaded profile
- snowfiled - snow + surface profile

## Profiles

- stock: stable kernel + modules
- backports: backport kernel + modules
- bootc: nbc & bootc, things that make bootable container
- oci: output oci image
- tar: output image tar (for nspawn)
- sysext-only: don't output "main" image
- loaded: some gui packages that don't flatpak well
- surface: linux-surface kernel

## Builds

- cayo = base <- cayo + profiles (stock + oci + bootc)
- cayo-bpo = base <- cayo + profiles (bpo + oci + bootc)
- snow = base <- snow + profiles (bpo + oci + bootc)
- snowloaded = base <- snow + profiles (bpo + oci + bootc + loaded)
- snowfield = base <- snow + profiles (bpo + oci + bootc + surface)
- incus = base << incus sysext
- docker = base << docker sysext
