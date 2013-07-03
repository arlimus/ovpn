ovpn
====

Dead simple OpenVPN manager for commandline.

```bash
> ovpn list
han/han1.ovpn
han/han2.ovpn
han/han3.ovpn
external/my-devel.ovpn

> ovpn start devel

> ovpn list
han/han1.ovpn
han/han2.ovpn
han/han3.ovpn
external/my-devel.ovpn (pid: 29157)

> ovpn stop devel
stopping 'external/my-devel.ovpn'
-- kill -9 29157
```

It searches for your profiles in `/etc/openvpn` by default.

It supports ambiguous specifications:

```bash
> ovpn start han
 1: han/han1.ovpn
 2: han/han2.ovpn
 3: han/han3.ovpn
Enter your choice (q for quit):  2

> ovpn list
han/han1.ovpn
han/han2.ovpn (pid: 30020)
han/han3.ovpn
external/my-devel.ovpn (pid: 29157)

> ovpn stop
stopping 'external/my-devel.ovpn'
-- kill -9 29157
stopping 'han2/han2.ovpn'
-- kill -9 30020
```



installation
------------

For now:

    gem build *gemspec && gem install *gem
