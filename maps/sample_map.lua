return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.2.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 100,
  height = 100,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 12,
  nextobjectid = 4,
  properties = {},
  tilesets = {
    {
      name = "Roguelike",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 1,
      margin = 0,
      columns = 57,
      image = "map_sheet.png",
      imagewidth = 968,
      imageheight = 526,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 1767,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 1,
      name = "Ground/terrain",
      x = 0,
      y = 0,
      width = 100,
      height = 100,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJzt100KwjAQgNGA1kOptZfy5/pGEKyhdiXOYN7i7Qc+ZkKmUsoEAAAAAAD8pV0jep6etS000QM9svnUQY9cXaLn6d2m2jaGBHP16liNjVOCuXrR7sNZj1BL+6CHHuiRzePtWHov9Iixthv76vp0SzBrD9Z62Im8PfzVf+NSXjfpUN5vlRsVa74rblW8+a7YDQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD4njvz4JUG"
    },
    {
      type = "tilelayer",
      id = 2,
      name = "Ground overlay",
      x = 0,
      y = 0,
      width = 100,
      height = 100,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJzt2VtOwkAUgOEWHrxtSsF1GF9chboMrWzDjRhZkTW0sRlaHWWAE/N9yUm4JuT8DCFQVQAAAAAAUM7ZrKrOu7mYHfvVsGgbLLu5zujxMq+q1WAooz8Xy8FcZpyRtIcmu+k7XCUtxs7Iqt5+vh5lLSY69PPQzrrezLMee3ff7fw06XDSzmPyWeV8HE7fpZ+0xSc9YtEjFj1i0SMWPWLRIxY9YtEjlrTHbbv7ptu/HoeX9li3u79xPo5m7PPqfb7pMhy2NfXX74Cvhf5XGutBnn3sTo+/K7W74Tl7G1yeGsaV6uFMlKFHLHrEkrvHnx6nRxlTe7yb5z0u937yTO0xvV2P/Wu++W6a3p5ef0quj/2Pzu/s8p52HsrTIxY9YtEjFj1i0SMWPf4PPQAAAAAAAAAAAAAAAAAAAAAAAACA3gfGHHlA"
    },
    {
      type = "tilelayer",
      id = 3,
      name = "Objects",
      x = 0,
      y = 0,
      width = 100,
      height = 100,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {
        ["collidable"] = true
      },
      encoding = "base64",
      compression = "zlib",
      data = "eJzt2k1u00AUwPHEThasWIFASKWw4giFEyCxgYDEBaAiZcUJEFJAQEGwZQt74BQtErDuFsQCuAUzyoyYvLz5sOtA6/x/0six49jVvLx5M04HAwAAAAAAAAA4nm5U//sv6Idrlb5t47ny2Ulw7M2w/bXXge37WaVvvZnSx9oxb2re2wne343E4yr5tCQWC9nfqZw5K957a/bfVfo5YTweEY8lufzwWy0fvplj391xmROxY0hL5YeWJzFhThwMl4+hTJtYpOZR4XsPC+5/kngtiMXAb3Nz2NKaHJ5HHY/L1Q15rlRak8PzqONxqbFKriVKa0lb7037YNrH1d7mSCtZf1jnWsTiZeIz9npy3Ppp2i/Tfje/VW+U1HJtnDrfQa7IcWvTzMsumHZxjdfwJfMqub/h9sOYvB6X35M5VZw2r/L58GAU/9xGgz7dMtfZqxePEROdNq/S6oenjVNbibihmcOuyz2tdof1uqTeTE0O3a/z5/WZNlbJWIT9NDHbm+71LbeNzaNS6wzZ99dN/dk2+/fWPB6p2u3HrNJ+uu3Of5Wp7Xcq+r7UYX6Likk9c/lB7YlqUzdi5PzrVPD62Xi5vWgwX+6z3O+AmvD7vme+3/umfXLf87CGN5kTY06LgXyOIfs8tFP/bVabZ4WrGCP7RPZp2Of7IjZTd7xknhpbA676OeVx5J/larXX9vnT0bzPL4/n7Yob7+086W4wV+K3je7JmEzrxRzR8uGM29rcmmRicsLE9lIdb0h7PJrngG1P3DilrR18HHcT8cg9t2Lsyvs8HAy+uPY18iy8yRyW/DgaeKbbnS77kvz4N0pjJtcbbdak6+h0B9cI+zr2v45+n3Xh6s0afPfJDQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACA9QctioWI"
    },
    {
      type = "tilelayer",
      id = 4,
      name = "Doors/windows/roof",
      x = 0,
      y = 0,
      width = 100,
      height = 100,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJzt17EuBEEYB/A5uSvwDBqd3qFGhUaj8QxEQ6vRewuOxyCh5SHo1Uh8m4hcuLu1uTm7Ob9fMslmtpjJ/9vZbzclAAAAAAAAABjfZoz5ujfBl6VWSi91bwLGtDBT9w7ot6cewD/30E7psV33LprvJjK6zZzT9+zv4nq2k9JcJ+860+goMnrLXI8i+9O+7Nfiej3GhnqUWo6MuplzGpT9cfwPnrTyrjNtriOfpxjPcmqkXf8ejVb0+vsJ9HuGG5X5azH3i35/4FxlMyrzote/t8v7/YV6ZFOW+U7FXn8YtVlRn4nZHzB3PiLvy7jX67vfU5vKtv7oe3dbbSpnsDjmequx3tXnml3vrh/OGpKHszFZw/JdHTLflOdiWpXlO6hezkh9nAcAAAAAAAAAAAAAAAAAAAAAAAAAAACAaj4AcbclqQ=="
    },
    {
      type = "tilelayer",
      id = 5,
      name = "Roof object",
      x = 0,
      y = 0,
      width = 100,
      height = 100,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJztzgENAAAIA6CbyP7tjKGbkIAEAAAAAAAAAAAAAG7q2h4AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHw3dOgAx"
    },
    {
      type = "objectgroup",
      id = 8,
      name = "Teleport",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 608,
          width = 16,
          height = 8,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "sample_indoor",
            ["x"] = 18,
            ["y"] = 19
          }
        }
      }
    }
  }
}
