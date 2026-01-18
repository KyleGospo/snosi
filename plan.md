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
