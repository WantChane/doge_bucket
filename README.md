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

| Name                                            | Mark |
| ----------------------------------------------- | ---- |
| [animeko](https://github.com/open-ani/animeko/) |      |

### Chat

| Name                       | Mark                                                                                        |
| -------------------------- | ------------------------------------------------------------------------------------------- |
| [Tim](https://tim.qq.com/) | [Scoopforge/Extras-CN](https://github.com/Scoopforge/Extras-CN/blob/master/bucket/tim.json) |

### MAA

| Name                                      | Mark                                                                                  |
| ----------------------------------------- | ------------------------------------------------------------------------------------- |
| [MaaAssistantArknights](https://maa.plus) | [cel-ti/maa-bucket](https://github.com/cel-ti/maa-bucket/blob/master/bucket/maa.json) |

### Minecraft Launcher

| Name                                                    | Mark                                                                                     |
| ------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| [BakaXL_InsiderParrot](https://www.bakaxl.com)          | 3.X 测试版                                                                               |
| [BakaXL_Sloth](https://www.bakaxl.com)                  | 3.X 正式版                                                                               |
| [HMCL](https://github.com/huanghongxun/HMCL)            | [okibcn/ScoopMaster](https://github.com/okibcn/ScoopMaster/blob/master/bucket/hmcl.json) |
| [PCL2](https://github.com/Hex-Dragon/PCL2)              | 该链接不稳定                                                                             |
| [PCL2-CE](https://pcl-community.github.io/PCL2-CE-Web/) |                                                                                          |
| [x-minecraft-launcher](https://xmcl.app/zh/)            |                                                                                          |

### Minecraft Server

| Name                                      | Mark |
| ----------------------------------------- | ---- |
| [MCSL2](https://v2.mcsl.com.cn/)          |      |
| [MCSManager](https://www.mcsmanager.com/) |      |
| [MSL](https://www.mslmc.cn/)              |      |

### Music

| Name                                                              | Mark                                                                                      |
| ----------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| [MusicFreeDesktop](https://github.com/maotoumao/MusicFreeDesktop) |                                                                                           |
| [listen1_desktop](http://listen1.github.io/listen1/)              | [extras](https://github.com/ScoopInstaller/Extras/blob/master/bucket/listen1desktop.json) |
| [lx-music-desktop](https://github.com/lyswhut/lx-music-desktop)   |                                                                                           |

### Tools

| Name                                                                   | Mark                                                                                                |
| ---------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| [Game-Cheats-Manager](https://github.com/dyang886/Game-Cheats-Manager) |                                                                                                     |
| [RegistryFinder](https://registry-finder.com/)                         | [okibcn/ScoopMaster](https://github.com/okibcn/ScoopMaster/blob/master/bucket/registry-finder.json) |
| [SwitchHosts](https://switchhosts.vercel.app/zh)                       | [extras](https://github.com/ScoopInstaller/Extras/blob/master/bucket/switchhosts.json)              |
| [zoxide](https://github.com/ajeetdsouza/zoxide)                        | [main](https://github.com/ScoopInstaller/Main/blob/master/bucket/zoxide.json)                       |

## 命名规范

1. 优先使用仓库名
2. 大驼峰命名
3. 使用下划线作为分隔符
