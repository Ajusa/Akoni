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
  nextlayerid = 6,
  nextobjectid = 4,
  backgroundcolor = { 0, 0, 0 },
  properties = {},
  tilesets = {
    {
      name = "roguelikeSheet_transparent",
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
      type = "objectgroup",
      id = 5,
      name = "Teleport",
      visible = true,
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
          x = 272,
          y = 336,
          width = 48,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "sample_map",
            ["x"] = "30",
            ["y"] = "39"
          }
        }
      }
    },
    {
      type = "tilelayer",
      id = 1,
      name = "Floor",
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
      data = "eJzt1kkKwkAQBdAmOavicAG9mtOt1K0GzEKwSm1C6+I96E2gNvVJ/y4FAADg945dKfvknLrv56IZ3jvfd7fq43MJdn5N5s7yqDbsbtbHZxnsfJ3MyKPesLttic882Pmij2fkUe9dHpvkyGN68vgvUV+P76Qsj+iNdZVHtaivx3dSlkf0Nhu6njpRX88+zCPqeqb3SR60I4//knW93m4v63q93V7W9Xq7vd3jXnpl+H5wXzU1/h+v+D8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAODZDYyhh0A="
    },
    {
      type = "tilelayer",
      id = 2,
      name = "Carpet",
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
      data = "eJzt1rENg0AMBVArRxuyF2sxBmSrEGAbKE8URCcRXcF70u9cWHZhRwAAAAAAcEdDihizvFPtju7ts89/yvK1j6qeTUSb5dXU7gjq6R7/radMXzjf0nqAqxzvwbz/t0uWNZ3Xc63jPfi1D/cDAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAiNk4sE4A="
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
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJzt1U1Kw0AYBuBJvUQRLHTlFfQm9ggue4UuLXgD0VWvYaGg4AnsuhfplEYacCaTYKSLPg+8fPMbhkAyIQAAAMBvd1UIL7F+hWMNjVqyq451FvMw+Mku07x+p1fVaex2dGq/ZeqPm5hJHf5uUZjfZuoysfZ5kBPRxWqUHt/EPFbpOforfR9dXMeMB3gO3bw3wv96LfQPPmI+Y+7r/9JTZn1qL/18F/oH60ba9qf2AnB5cveze/s8mvfzNDMOAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAbfYkoh2w"
    },
    {
      type = "tilelayer",
      id = 4,
      name = "Details",
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
      data = "eJztziEBACAMAMEBMchICZJTYGJuiDvz9iMAAAAgt0deoObM7gMq7uo+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAH7zAKpOAUk="
    }
  }
}
