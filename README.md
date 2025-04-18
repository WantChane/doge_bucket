# Doge Bucket

## ⚠️注意事项⚠️

1. 该仓库部分软件安装步骤中含有注册表操作, 例如 PCL2
2. 该仓库部分软件安装步骤中需要访问 Scoop 安装目录下 buckets\doge 文件夹, 因此不建议修改下面命令中的仓库名
3. 该仓库部分软件安装步骤中会操作非 Scoop 目录, 例如 Tim 会在 Documents 文件夹下新建软链接

```powershell
scoop bucket add doge https://github.com/WantChane/doge_bucket.git
```

## 收录清单

### Anime

| Name                                            | Mark                                                                                                           |
| ----------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| [animeko](https://github.com/open-ani/animeko/) |                                                                                                                |
| [DanDanPlay](https://www.dandanplay.com/)       | [ZhangTianrong/scoop-bucket](https://github.com/ZhangTianrong/scoop-bucket/blob/master/bucket/dandanplay.json) |

### Browser

| Name                                            | Mark                                                                             |
| ----------------------------------------------- | -------------------------------------------------------------------------------- |
| [firefox](https://www.mozilla.org/firefox/)     | [main](https://github.com/ScoopInstaller/Extras/blob/master/bucket/firefox.json) |
| [zen-browser_desktop](https://zen-browser.app/) |                                                                                  |

### Chat

| Name                       | Mark                                                                                        |
| -------------------------- | ------------------------------------------------------------------------------------------- |
| [Tim](https://tim.qq.com/) | [Scoopforge/Extras-CN](https://github.com/Scoopforge/Extras-CN/blob/master/bucket/tim.json) |

### Game

#### Arknights

| Name                                      | Mark                                                                                  |
| ----------------------------------------- | ------------------------------------------------------------------------------------- |
| [MaaAssistantArknights](https://maa.plus) | [cel-ti/maa-bucket](https://github.com/cel-ti/maa-bucket/blob/master/bucket/maa.json) |

#### Minecraft Launcher

| Name                                                    | Mark                                                                                     |
| ------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| [BakaXL_InsiderParrot](https://www.bakaxl.com)          | 3.X 测试版                                                                               |
| [BakaXL_Sloth](https://www.bakaxl.com)                  | 3.X 正式版                                                                               |
| [HMCL](https://github.com/huanghongxun/HMCL)            | [okibcn/ScoopMaster](https://github.com/okibcn/ScoopMaster/blob/master/bucket/hmcl.json) |
| [PCL2](https://github.com/Hex-Dragon/PCL2)              | 该链接不稳定                                                                             |
| [PCL2-CE](https://pcl-community.github.io/PCL2-CE-Web/) |                                                                                          |
| [x-minecraft-launcher](https://xmcl.app/zh/)            |                                                                                          |

#### Minecraft Server

| Name                                      | Mark |
| ----------------------------------------- | ---- |
| [MCSL2](https://v2.mcsl.com.cn/)          |      |
| [MCSManager](https://www.mcsmanager.com/) |      |
| [MSL](https://www.mslmc.cn/)              |      |

#### Other

| Name                                                                   | Mark |
| ---------------------------------------------------------------------- | ---- |
| [Game-Cheats-Manager](https://github.com/dyang886/Game-Cheats-Manager) |      |

### Music

| Name                                                              | Mark                                                                                      |
| ----------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| [listen1_desktop](http://listen1.github.io/listen1/)              | [extras](https://github.com/ScoopInstaller/Extras/blob/master/bucket/listen1desktop.json) |
| [lx-music-desktop](https://github.com/lyswhut/lx-music-desktop)   |                                                                                           |
| [MusicFreeDesktop](https://github.com/maotoumao/MusicFreeDesktop) |                                                                                           |

### Player

| Name                                                    | Mark                                              |
| ------------------------------------------------------- | ------------------------------------------------- |
| [MPV_lazy](https://github.com/hooke007/MPV_lazy)        | mpv-lazy 标准包, 执行 installer/mpv-install. bat  |
| [MPV_lazy_unique](https://github.com/hooke007/MPV_lazy) | mpv-lazy 标准包, 执行 installer/umpv-install. bat |
| [MPV_lazy_vsNV](https://github.com/hooke007/MPV_lazy)   | mpv-lazy vsNV 补丁包 <br>                         |

### Tools

| Name                                             | Mark                                                                                                |
| ------------------------------------------------ | --------------------------------------------------------------------------------------------------- |
| [eza](https://github.com/eza-community/eza)      | [main](https://github.com/ScoopInstaller/Main/blob/master/bucket/eza.json)                          |
| [PicList](https://piclist.cn/)                   | [hoilc/scoop-lemon](https://github.com/hoilc/scoop-lemon/blob/master/bucket/piclist.json)           |
| [RegistryFinder](https://registry-finder.com/)   | [okibcn/ScoopMaster](https://github.com/okibcn/ScoopMaster/blob/master/bucket/registry-finder.json) |
| [SwitchHosts](https://switchhosts.vercel.app/zh) | [extras](https://github.com/ScoopInstaller/Extras/blob/master/bucket/switchhosts.json)              |
| [zoxide](https://github.com/ajeetdsouza/zoxide)  | [main](https://github.com/ScoopInstaller/Main/blob/master/bucket/zoxide.json)                       |

## 命名规范

1. 优先使用仓库名
2. 大驼峰命名
3. 使用下划线作为分隔符
