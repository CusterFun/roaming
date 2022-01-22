1. 获取数据库名

```
GET /autoCode/getDB

{
    "code":0,
    "data":{
        "dbs":[
            {
                "database":"mysql"
            },
            {
                "database":"information_schema"
            }
        ]
    },
    "msg":"获取成功"
}
```

```sql
SELECT SCHEMA_NAME AS `database` FROM INFORMATION_SCHEMA.SCHEMATA;
```

2. 通过数据库名获取表名

```
GET /autoCode/getTables?dbName=test


{
    "code":0,
    "data":{
        "tables":[
            {
                "tableName":"authority_matter"
            },
            {
                "tableName":"authority_menu"
            }
        ]
    },
    "msg":"获取成功"
}
```

```sql
select table_name as table_name from information_schema.tables where table_schema = "task";
```

3. 通过数据库名和表名获取字段

```
GET /autoCode/getColumn?dbName=music&tableName=cs_lessons

{
    "code":0,
    "data":{
        "columns":[
            {
                "dataType":"bigint",
                "columnName":"id",
                "dataTypeLong":"20",
                "columnComment":""
            }
        ]
    },
    "msg":"获取成功"
}
```

```sql
SELECT COLUMN_NAME        column_name,
       DATA_TYPE          data_type,
       CASE DATA_TYPE
           WHEN 'longtext' THEN c.CHARACTER_MAXIMUM_LENGTH
           WHEN 'varchar' THEN c.CHARACTER_MAXIMUM_LENGTH
           WHEN 'double' THEN CONCAT_WS(',', c.NUMERIC_PRECISION, c.NUMERIC_SCALE)
           WHEN 'decimal' THEN CONCAT_WS(',', c.NUMERIC_PRECISION, c.NUMERIC_SCALE)
           WHEN 'int' THEN c.NUMERIC_PRECISION
           WHEN 'bigint' THEN c.NUMERIC_PRECISION
           ELSE '' END AS data_type_long,
       COLUMN_COMMENT     column_comment
	FROM INFORMATION_SCHEMA.COLUMNS c
	WHERE table_name = "business"
	  AND table_schema = "task";

SELECT COLUMN_NAME, DATA_TYPE, COLUMN_KEY, IS_NULLABLE, COLUMN_TYPE, COLUMN_COMMENT FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = "task" AND TABLE_NAME = "business";
```

4. 预览自动生成代码

````
POST  /autoCode/preview

{
    "structName":"ShortLinks", Struct名称
    "tableName":"short_links", TableName
    "packageName":"shortLinks", 文件名称
    "abbreviation":"shortLinks",  Struct简称
    "description":"shortLinks表", Struct中文名称
    "autoCreateApiToSql":true, 自动创建API
    "autoMoveFile":false, 自动移动文件
    "fields":[
        {
            "fieldName":"Url",
            "fieldDesc":"url字段",
            "fieldType":"string",
            "dataType":"varchar",
            "fieldJson":"url",
            "dataTypeLong":"255",
            "columnName":"url",
            "comment":"",
            "fieldSearchType":"",
            "dictType":""
        },
        {
            "fieldName":"Desc",
            "fieldDesc":"描述",
            "fieldType":"string",
            "dataType":"",
            "fieldJson":"desc",
            "columnName":"desc",
            "dataTypeLong":"",
            "comment":"描述",
            "fieldSearchType":"",
            "dictType":""
        }
    ],
    "humpPackageName":"short_links" 文件名称
}

{
    "code":0,
    "data":{
        "autoCode":{
            "server-api":"```go\n\npackage autocode\n\nimport (\n\t\"github.com/flipped-aurora/gin-vue-admin/server/global\"\n    \"github.com/flipped-aurora/gin-vue-admin/server/model/autocode\"\n    \"github.com/flipped-aurora/gin-vue-admin/server/model/common/request\"\n    autocodeReq \"github.com/flipped-aurora/gin-vue-admin/server/model/autocode/request\"\n    \"github.com/flipped-aurora/gin-vue-admin/server/model/common/response\"\n    \"github.com/flipped-aurora/gin-vue-admin/server/service\"\n    \"github.com/gin-gonic/gin\"\n    \"go.uber.org/zap\"\n)\n\ntype ShortLinksApi struct {\n}\n\nvar shortLinksService = service.ServiceGroupApp.AutoCodeServiceGroup.ShortLinksService\n\n\n// CreateShortLinks 创建ShortLinks\n// @Tags ShortLinks\n// @Summary 创建ShortLinks\n// @Security ApiKeyAuth\n// @accept application/json\n// @Produce application/json\n// @Param data body autocode.ShortLinks true \"创建ShortLinks\"\n// @Success 200 {string} string \"{\"success\":true,\"data\":{},\"msg\":\"获取成功\"}\"\n// @Router /shortLinks/createShortLinks [post]\nfunc (shortLinksApi *ShortLinksApi) CreateShortLinks(c *gin.Context) {\n\tvar shortLinks autocode.ShortLinks\n\t_ = c.ShouldBindJSON(\u0026shortLinks)\n\tif err := shortLinksService.CreateShortLinks(shortLinks); err != nil {\n        global.GVA_LOG.Error(\"创建失败!\", zap.Error(err))\n\t\tresponse.FailWithMessage(\"创建失败\", c)\n\t} else {\n\t\tresponse.OkWithMessage(\"创建成功\", c)\n\t}\n}\n\n// DeleteShortLinks 删除ShortLinks\n// @Tags ShortLinks\n// @Summary 删除ShortLinks\n// @Security ApiKeyAuth\n// @accept application/json\n// @Produce application/json\n// @Param data body autocode.ShortLinks true \"删除ShortLinks\"\n// @Success 200 {string} string \"{\"success\":true,\"data\":{},\"msg\":\"删除成功\"}\"\n// @Router /shortLinks/deleteShortLinks [delete]\nfunc (shortLinksApi *ShortLinksApi) DeleteShortLinks(c *gin.Context) {\n\tvar shortLinks autocode.ShortLinks\n\t_ = c.ShouldBindJSON(\u0026shortLinks)\n\tif err := shortLinksService.DeleteShortLinks(shortLinks); err != nil {\n        global.GVA_LOG.Error(\"删除失败!\", zap.Error(err))\n\t\tresponse.FailWithMessage(\"删除失败\", c)\n\t} else {\n\t\tresponse.OkWithMessage(\"删除成功\", c)\n\t}\n}\n\n// DeleteShortLinksByIds 批量删除ShortLinks\n// @Tags ShortLinks\n// @Summary 批量删除ShortLinks\n// @Security ApiKeyAuth\n// @accept application/json\n// @Produce application/json\n// @Param data body request.IdsReq true \"批量删除ShortLinks\"\n// @Success 200 {string} string \"{\"success\":true,\"data\":{},\"msg\":\"批量删除成功\"}\"\n// @Router /shortLinks/deleteShortLinksByIds [delete]\nfunc (shortLinksApi *ShortLinksApi) DeleteShortLinksByIds(c *gin.Context) {\n\tvar IDS request.IdsReq\n    _ = c.ShouldBindJSON(\u0026IDS)\n\tif err := shortLinksService.DeleteShortLinksByIds(IDS); err != nil {\n        global.GVA_LOG.Error(\"批量删除失败!\", zap.Error(err))\n\t\tresponse.FailWithMessage(\"批量删除失败\", c)\n\t} else {\n\t\tresponse.OkWithMessage(\"批量删除成功\", c)\n\t}\n}\n\n// UpdateShortLinks 更新ShortLinks\n// @Tags ShortLinks\n// @Summary 更新ShortLinks\n// @Security ApiKeyAuth\n// @accept application/json\n// @Produce application/json\n// @Param data body autocode.ShortLinks true \"更新ShortLinks\"\n// @Success 200 {string} string \"{\"success\":true,\"data\":{},\"msg\":\"更新成功\"}\"\n// @Router /shortLinks/updateShortLinks [put]\nfunc (shortLinksApi *ShortLinksApi) UpdateShortLinks(c *gin.Context) {\n\tvar shortLinks autocode.ShortLinks\n\t_ = c.ShouldBindJSON(\u0026shortLinks)\n\tif err := shortLinksService.UpdateShortLinks(shortLinks); err != nil {\n        global.GVA_LOG.Error(\"更新失败!\", zap.Error(err))\n\t\tresponse.FailWithMessage(\"更新失败\", c)\n\t} else {\n\t\tresponse.OkWithMessage(\"更新成功\", c)\n\t}\n}\n\n// FindShortLinks 用id查询ShortLinks\n// @Tags ShortLinks\n// @Summary 用id查询ShortLinks\n// @Security ApiKeyAuth\n// @accept application/json\n// @Produce application/json\n// @Param data query autocode.ShortLinks true \"用id查询ShortLinks\"\n// @Success 200 {string} string \"{\"success\":true,\"data\":{},\"msg\":\"查询成功\"}\"\n// @Router /shortLinks/findShortLinks [get]\nfunc (shortLinksApi *ShortLinksApi) FindShortLinks(c *gin.Context) {\n\tvar shortLinks autocode.ShortLinks\n\t_ = c.ShouldBindQuery(\u0026shortLinks)\n\tif err, reshortLinks := shortLinksService.GetShortLinks(shortLinks.ID); err != nil {\n        global.GVA_LOG.Error(\"查询失败!\", zap.Error(err))\n\t\tresponse.FailWithMessage(\"查询失败\", c)\n\t} else {\n\t\tresponse.OkWithData(gin.H{\"reshortLinks\": reshortLinks}, c)\n\t}\n}\n\n// GetShortLinksList 分页获取ShortLinks列表\n// @Tags ShortLinks\n// @Summary 分页获取ShortLinks列表\n// @Security ApiKeyAuth\n// @accept application/json\n// @Produce application/json\n// @Param data query autocodeReq.ShortLinksSearch true \"分页获取ShortLinks列表\"\n// @Success 200 {string} string \"{\"success\":true,\"data\":{},\"msg\":\"获取成功\"}\"\n// @Router /shortLinks/getShortLinksList [get]\nfunc (shortLinksApi *ShortLinksApi) GetShortLinksList(c *gin.Context) {\n\tvar pageInfo autocodeReq.ShortLinksSearch\n\t_ = c.ShouldBindQuery(\u0026pageInfo)\n\tif err, list, total := shortLinksService.GetShortLinksInfoList(pageInfo); err != nil {\n\t    global.GVA_LOG.Error(\"获取失败!\", zap.Error(err))\n        response.FailWithMessage(\"获取失败\", c)\n    } else {\n        response.OkWithDetailed(response.PageResult{\n            List:     list,\n            Total:    total,\n            Page:     pageInfo.Page,\n            PageSize: pageInfo.PageSize,\n        }, \"获取成功\", c)\n    }\n}\n\n\n```",


            "server-model":"```go\n\n// 自动生成模板ShortLinks\npackage autocode\n\nimport (\n\t\"github.com/flipped-aurora/gin-vue-admin/server/global\"\n)\n\n// ShortLinks 结构体\n// 如果含有time.Time 请自行import time包\ntype ShortLinks struct {\n      global.GVA_MODEL\n      Url  string `json:\"url\" form:\"url\" gorm:\"column:url;comment:;size:255;\"`\n      Desc  string `json:\"desc\" form:\"desc\" gorm:\"column:desc;comment:描述;\"`\n}\n\n\n// TableName ShortLinks 表名\nfunc (ShortLinks) TableName() string {\n  return \"short_links\"\n}\n\n\n\n```",


            "server-request":"```go\n\npackage request\n\nimport (\n\t\"github.com/flipped-aurora/gin-vue-admin/server/model/autocode\"\n\t\"github.com/flipped-aurora/gin-vue-admin/server/model/common/request\"\n)\n\ntype ShortLinksSearch struct{\n    autocode.ShortLinks\n    request.PageInfo\n}\n\n```",


            "server-router":"```go\n\npackage autocode\n\nimport (\n\t\"github.com/flipped-aurora/gin-vue-admin/server/api/v1\"\n\t\"github.com/flipped-aurora/gin-vue-admin/server/middleware\"\n\t\"github.com/gin-gonic/gin\"\n)\n\ntype ShortLinksRouter struct {\n}\n\n// InitShortLinksRouter 初始化 ShortLinks 路由信息\nfunc (s *ShortLinksRouter) InitShortLinksRouter(Router *gin.RouterGroup) {\n\tshortLinksRouter := Router.Group(\"shortLinks\").Use(middleware.OperationRecord())\n\tshortLinksRouterWithoutRecord := Router.Group(\"shortLinks\")\n\tvar shortLinksApi = v1.ApiGroupApp.AutoCodeApiGroup.ShortLinksApi\n\t{\n\t\tshortLinksRouter.POST(\"createShortLinks\", shortLinksApi.CreateShortLinks)   // 新建ShortLinks\n\t\tshortLinksRouter.DELETE(\"deleteShortLinks\", shortLinksApi.DeleteShortLinks) // 删除ShortLinks\n\t\tshortLinksRouter.DELETE(\"deleteShortLinksByIds\", shortLinksApi.DeleteShortLinksByIds) // 批量删除ShortLinks\n\t\tshortLinksRouter.PUT(\"updateShortLinks\", shortLinksApi.UpdateShortLinks)    // 更新ShortLinks\n\t}\n\t{\n\t\tshortLinksRouterWithoutRecord.GET(\"findShortLinks\", shortLinksApi.FindShortLinks)        // 根据ID获取ShortLinks\n\t\tshortLinksRouterWithoutRecord.GET(\"getShortLinksList\", shortLinksApi.GetShortLinksList)  // 获取ShortLinks列表\n\t}\n}\n\n\n```",


            "server-service":"```go\n\npackage autocode\n\nimport (\n\t\"github.com/flipped-aurora/gin-vue-admin/server/global\"\n\t\"github.com/flipped-aurora/gin-vue-admin/server/model/autocode\"\n\t\"github.com/flipped-aurora/gin-vue-admin/server/model/common/request\"\n    autoCodeReq \"github.com/flipped-aurora/gin-vue-admin/server/model/autocode/request\"\n)\n\ntype ShortLinksService struct {\n}\n\n// CreateShortLinks 创建ShortLinks记录\n// Author [piexlmax](https://github.com/piexlmax)\nfunc (shortLinksService *ShortLinksService) CreateShortLinks(shortLinks autocode.ShortLinks) (err error) {\n\terr = global.GVA_DB.Create(\u0026shortLinks).Error\n\treturn err\n}\n\n// DeleteShortLinks 删除ShortLinks记录\n// Author [piexlmax](https://github.com/piexlmax)\nfunc (shortLinksService *ShortLinksService)DeleteShortLinks(shortLinks autocode.ShortLinks) (err error) {\n\terr = global.GVA_DB.Delete(\u0026shortLinks).Error\n\treturn err\n}\n\n// DeleteShortLinksByIds 批量删除ShortLinks记录\n// Author [piexlmax](https://github.com/piexlmax)\nfunc (shortLinksService *ShortLinksService)DeleteShortLinksByIds(ids request.IdsReq) (err error) {\n\terr = global.GVA_DB.Delete(\u0026[]autocode.ShortLinks{},\"id in ?\",ids.Ids).Error\n\treturn err\n}\n\n// UpdateShortLinks 更新ShortLinks记录\n// Author [piexlmax](https://github.com/piexlmax)\nfunc (shortLinksService *ShortLinksService)UpdateShortLinks(shortLinks autocode.ShortLinks) (err error) {\n\terr = global.GVA_DB.Save(\u0026shortLinks).Error\n\treturn err\n}\n\n// GetShortLinks 根据id获取ShortLinks记录\n// Author [piexlmax](https://github.com/piexlmax)\nfunc (shortLinksService *ShortLinksService)GetShortLinks(id uint) (err error, shortLinks autocode.ShortLinks) {\n\terr = global.GVA_DB.Where(\"id = ?\", id).First(\u0026shortLinks).Error\n\treturn\n}\n\n// GetShortLinksInfoList 分页获取ShortLinks记录\n// Author [piexlmax](https://github.com/piexlmax)\nfunc (shortLinksService *ShortLinksService)GetShortLinksInfoList(info autoCodeReq.ShortLinksSearch) (err error, list interface{}, total int64) {\n\tlimit := info.PageSize\n\toffset := info.PageSize * (info.Page - 1)\n    // 创建db\n\tdb := global.GVA_DB.Model(\u0026autocode.ShortLinks{})\n    var shortLinkss []autocode.ShortLinks\n    // 如果有条件搜索 下方会自动创建搜索语句\n\terr = db.Count(\u0026total).Error\n\tif err!=nil {\n    \treturn\n    }\n\terr = db.Limit(limit).Offset(offset).Find(\u0026shortLinkss).Error\n\treturn err, shortLinkss, total\n}\n\n\n```",


            "web-api":"```js\n\nimport service from '@/utils/request'\n\n// @Tags ShortLinks\n// @Summary 创建ShortLinks\n// @Security ApiKeyAuth\n// @accept application/json\n// @Produce application/json\n// @Param data body model.ShortLinks true \"创建ShortLinks\"\n// @Success 200 {string} string \"{\"success\":true,\"data\":{},\"msg\":\"获取成功\"}\"\n// @Router /shortLinks/createShortLinks [post]\nexport const createShortLinks = (data) =\u003e {\n  return service({\n    url: '/shortLinks/createShortLinks',\n    method: 'post',\n    data\n  })\n}\n\n// @Tags ShortLinks\n// @Summary 删除ShortLinks\n// @Security ApiKeyAuth\n// @accept application/json\n// @Produce application/json\n// @Param data body model.ShortLinks true \"删除ShortLinks\"\n// @Success 200 {string} string \"{\"success\":true,\"data\":{},\"msg\":\"删除成功\"}\"\n// @Router /shortLinks/deleteShortLinks [delete]\nexport const deleteShortLinks = (data) =\u003e {\n  return service({\n    url: '/shortLinks/deleteShortLinks',\n    method: 'delete',\n    data\n  })\n}\n\n// @Tags ShortLinks\n// @Summary 删除ShortLinks\n// @Security ApiKeyAuth\n// @accept application/json\n// @Produce application/json\n// @Param data body request.IdsReq true \"批量删除ShortLinks\"\n// @Success 200 {string} string \"{\"success\":true,\"data\":{},\"msg\":\"删除成功\"}\"\n// @Router /shortLinks/deleteShortLinks [delete]\nexport const deleteShortLinksByIds = (data) =\u003e {\n  return service({\n    url: '/shortLinks/deleteShortLinksByIds',\n    method: 'delete',\n    data\n  })\n}\n\n// @Tags ShortLinks\n// @Summary 更新ShortLinks\n// @Security ApiKeyAuth\n// @accept application/json\n// @Produce application/json\n// @Param data body model.ShortLinks true \"更新ShortLinks\"\n// @Success 200 {string} string \"{\"success\":true,\"data\":{},\"msg\":\"更新成功\"}\"\n// @Router /shortLinks/updateShortLinks [put]\nexport const updateShortLinks = (data) =\u003e {\n  return service({\n    url: '/shortLinks/updateShortLinks',\n    method: 'put',\n    data\n  })\n}\n\n// @Tags ShortLinks\n// @Summary 用id查询ShortLinks\n// @Security ApiKeyAuth\n// @accept application/json\n// @Produce application/json\n// @Param data query model.ShortLinks true \"用id查询ShortLinks\"\n// @Success 200 {string} string \"{\"success\":true,\"data\":{},\"msg\":\"查询成功\"}\"\n// @Router /shortLinks/findShortLinks [get]\nexport const findShortLinks = (params) =\u003e {\n  return service({\n    url: '/shortLinks/findShortLinks',\n    method: 'get',\n    params\n  })\n}\n\n// @Tags ShortLinks\n// @Summary 分页获取ShortLinks列表\n// @Security ApiKeyAuth\n// @accept application/json\n// @Produce application/json\n// @Param data query request.PageInfo true \"分页获取ShortLinks列表\"\n// @Success 200 {string} string \"{\"success\":true,\"data\":{},\"msg\":\"获取成功\"}\"\n// @Router /shortLinks/getShortLinksList [get]\nexport const getShortLinksList = (params) =\u003e {\n  return service({\n    url: '/shortLinks/getShortLinksList',\n    method: 'get',\n    params\n  })\n}\n\n\n```",


            "web-form":"```vue\n\n\u003ctemplate\u003e\n  \u003cdiv\u003e\n    \u003cdiv class=\"gva-form-box\"\u003e\n      \u003cel-form :model=\"formData\" label-position=\"right\" label-width=\"80px\"\u003e\n        \u003cel-form-item label=\"url字段:\"\u003e\n          \u003cel-input v-model=\"formData.url\" clearable placeholder=\"请输入\" /\u003e\n        \u003c/el-form-item\u003e\n        \u003cel-form-item label=\"描述:\"\u003e\n          \u003cel-input v-model=\"formData.desc\" clearable placeholder=\"请输入\" /\u003e\n        \u003c/el-form-item\u003e\n        \u003cel-form-item\u003e\n          \u003cel-button size=\"mini\" type=\"primary\" @click=\"save\"\u003e保存\u003c/el-button\u003e\n          \u003cel-button size=\"mini\" type=\"primary\" @click=\"back\"\u003e返回\u003c/el-button\u003e\n        \u003c/el-form-item\u003e\n      \u003c/el-form\u003e\n    \u003c/div\u003e\n  \u003c/div\u003e\n\u003c/template\u003e\n\n\u003cscript\u003e\nimport {\n  createShortLinks,\n  updateShortLinks,\n  findShortLinks\n} from '@/api/shortLinks' //  此处请自行替换地址\nimport infoList from '@/mixins/infoList'\nexport default {\n  name: 'ShortLinks',\n  mixins: [infoList],\n  data() {\n    return {\n      type: '',\n      formData: {\n        url: '',\n        desc: '',\n      }\n    }\n  },\n  async created() {\n    // 建议通过url传参获取目标数据ID 调用 find方法进行查询数据操作 从而决定本页面是create还是update 以下为id作为url参数示例\n    if (this.$route.query.id) {\n      const res = await findShortLinks({ ID: this.$route.query.id })\n      if (res.code === 0) {\n        this.formData = res.data.reshortLinks\n        this.type = 'update'\n      }\n    } else {\n      this.type = 'create'\n    }\n  },\n  methods: {\n    async save() {\n      let res\n      switch (this.type) {\n        case 'create':\n          res = await createShortLinks(this.formData)\n          break\n        case 'update':\n          res = await updateShortLinks(this.formData)\n          break\n        default:\n          res = await createShortLinks(this.formData)\n          break\n      }\n      if (res.code === 0) {\n        this.$message({\n          type: 'success',\n          message: '创建/更改成功'\n        })\n      }\n    },\n    back() {\n      this.$router.go(-1)\n    }\n  }\n}\n\u003c/script\u003e\n\n\u003cstyle\u003e\n\u003c/style\u003e\n\n\n```",


            "web-table":"```vue\n\n\u003ctemplate\u003e\n  \u003cdiv\u003e\n    \u003cdiv class=\"gva-search-box\"\u003e\n      \u003cel-form :inline=\"true\" :model=\"searchInfo\" class=\"demo-form-inline\"\u003e\n        \u003cel-form-item\u003e\n          \u003cel-button size=\"mini\" type=\"primary\" icon=\"search\" @click=\"onSubmit\"\u003e查询\u003c/el-button\u003e\n          \u003cel-button size=\"mini\" icon=\"refresh\" @click=\"onReset\"\u003e重置\u003c/el-button\u003e\n        \u003c/el-form-item\u003e\n      \u003c/el-form\u003e\n    \u003c/div\u003e\n    \u003cdiv class=\"gva-table-box\"\u003e\n        \u003cdiv class=\"gva-btn-list\"\u003e\n            \u003cel-button size=\"mini\" type=\"primary\" icon=\"plus\" @click=\"openDialog\"\u003e新增\u003c/el-button\u003e\n            \u003cel-popover v-model:visible=\"deleteVisible\" placement=\"top\" width=\"160\"\u003e\n            \u003cp\u003e确定要删除吗？\u003c/p\u003e\n            \u003cdiv style=\"text-align: right; margin-top: 8px;\"\u003e\n                \u003cel-button size=\"mini\" type=\"text\" @click=\"deleteVisible = false\"\u003e取消\u003c/el-button\u003e\n                \u003cel-button size=\"mini\" type=\"primary\" @click=\"onDelete\"\u003e确定\u003c/el-button\u003e\n            \u003c/div\u003e\n            \u003ctemplate #reference\u003e\n                \u003cel-button icon=\"delete\" size=\"mini\" style=\"margin-left: 10px;\" :disabled=\"!multipleSelection.length\"\u003e删除\u003c/el-button\u003e\n            \u003c/template\u003e\n            \u003c/el-popover\u003e\n        \u003c/div\u003e\n        \u003cel-table\n        ref=\"multipleTable\"\n        style=\"width: 100%\"\n        tooltip-effect=\"dark\"\n        :data=\"tableData\"\n        row-key=\"ID\"\n        @selection-change=\"handleSelectionChange\"\n        \u003e\n        \u003cel-table-column type=\"selection\" width=\"55\" /\u003e\n        \u003cel-table-column align=\"left\" label=\"日期\" width=\"180\"\u003e\n            \u003ctemplate #default=\"scope\"\u003e{{ formatDate(scope.row.CreatedAt) }}\u003c/template\u003e\n        \u003c/el-table-column\u003e\n        \u003cel-table-column align=\"left\" label=\"url字段\" prop=\"url\" width=\"120\" /\u003e\n        \u003cel-table-column align=\"left\" label=\"描述\" prop=\"desc\" width=\"120\" /\u003e\n        \u003cel-table-column align=\"left\" label=\"按钮组\"\u003e\n            \u003ctemplate #default=\"scope\"\u003e\n            \u003cel-button type=\"text\" icon=\"edit\" size=\"small\" class=\"table-button\" @click=\"updateShortLinks(scope.row)\"\u003e变更\u003c/el-button\u003e\n            \u003cel-button type=\"text\" icon=\"delete\" size=\"mini\" @click=\"deleteRow(scope.row)\"\u003e删除\u003c/el-button\u003e\n            \u003c/template\u003e\n        \u003c/el-table-column\u003e\n        \u003c/el-table\u003e\n        \u003cdiv class=\"gva-pagination\"\u003e\n            \u003cel-pagination\n            layout=\"total, sizes, prev, pager, next, jumper\"\n            :current-page=\"page\"\n            :page-size=\"pageSize\"\n            :page-sizes=\"[10, 30, 50, 100]\"\n            :total=\"total\"\n            @current-change=\"handleCurrentChange\"\n            @size-change=\"handleSizeChange\"\n            /\u003e\n        \u003c/div\u003e\n    \u003c/div\u003e\n    \u003cel-dialog v-model=\"dialogFormVisible\" :before-close=\"closeDialog\" title=\"弹窗操作\"\u003e\n      \u003cel-form :model=\"formData\" label-position=\"right\" label-width=\"80px\"\u003e\n        \u003cel-form-item label=\"url字段:\"\u003e\n          \u003cel-input v-model=\"formData.url\" clearable placeholder=\"请输入\" /\u003e\n        \u003c/el-form-item\u003e\n        \u003cel-form-item label=\"描述:\"\u003e\n          \u003cel-input v-model=\"formData.desc\" clearable placeholder=\"请输入\" /\u003e\n        \u003c/el-form-item\u003e\n      \u003c/el-form\u003e\n      \u003ctemplate #footer\u003e\n        \u003cdiv class=\"dialog-footer\"\u003e\n          \u003cel-button size=\"small\" @click=\"closeDialog\"\u003e取 消\u003c/el-button\u003e\n          \u003cel-button size=\"small\" type=\"primary\" @click=\"enterDialog\"\u003e确 定\u003c/el-button\u003e\n        \u003c/div\u003e\n      \u003c/template\u003e\n    \u003c/el-dialog\u003e\n  \u003c/div\u003e\n\u003c/template\u003e\n\n\u003cscript\u003e\nimport {\n  createShortLinks,\n  deleteShortLinks,\n  deleteShortLinksByIds,\n  updateShortLinks,\n  findShortLinks,\n  getShortLinksList\n} from '@/api/shortLinks' //  此处请自行替换地址\nimport infoList from '@/mixins/infoList'\nexport default {\n  name: 'ShortLinks',\n  mixins: [infoList],\n  data() {\n    return {\n      listApi: getShortLinksList,\n      dialogFormVisible: false,\n      type: '',\n      deleteVisible: false,\n      multipleSelection: [],\n      formData: {\n        url: '',\n        desc: '',\n      }\n    }\n  },\n  async created() {\n    await this.getTableData()\n  },\n  methods: {\n  onReset() {\n    this.searchInfo = {}\n  },\n  // 条件搜索前端看此方法\n    onSubmit() {\n      this.page = 1\n      this.pageSize = 10\n      this.getTableData()\n    },\n    handleSelectionChange(val) {\n      this.multipleSelection = val\n    },\n    deleteRow(row) {\n      this.$confirm('确定要删除吗?', '提示', {\n        confirmButtonText: '确定',\n        cancelButtonText: '取消',\n        type: 'warning'\n      }).then(() =\u003e {\n        this.deleteShortLinks(row)\n      })\n    },\n    async onDelete() {\n      const ids = []\n      if (this.multipleSelection.length === 0) {\n        this.$message({\n          type: 'warning',\n          message: '请选择要删除的数据'\n        })\n        return\n      }\n      this.multipleSelection \u0026\u0026\n        this.multipleSelection.map(item =\u003e {\n          ids.push(item.ID)\n        })\n      const res = await deleteShortLinksByIds({ ids })\n      if (res.code === 0) {\n        this.$message({\n          type: 'success',\n          message: '删除成功'\n        })\n        if (this.tableData.length === ids.length \u0026\u0026 this.page \u003e 1) {\n          this.page--\n        }\n        this.deleteVisible = false\n        this.getTableData()\n      }\n    },\n    async updateShortLinks(row) {\n      const res = await findShortLinks({ ID: row.ID })\n      this.type = 'update'\n      if (res.code === 0) {\n        this.formData = res.data.reshortLinks\n        this.dialogFormVisible = true\n      }\n    },\n    closeDialog() {\n      this.dialogFormVisible = false\n      this.formData = {\n        url: '',\n        desc: '',\n      }\n    },\n    async deleteShortLinks(row) {\n      const res = await deleteShortLinks({ ID: row.ID })\n      if (res.code === 0) {\n        this.$message({\n          type: 'success',\n          message: '删除成功'\n        })\n        if (this.tableData.length === 1 \u0026\u0026 this.page \u003e 1) {\n          this.page--\n        }\n        this.getTableData()\n      }\n    },\n    async enterDialog() {\n      let res\n      switch (this.type) {\n        case 'create':\n          res = await createShortLinks(this.formData)\n          break\n        case 'update':\n          res = await updateShortLinks(this.formData)\n          break\n        default:\n          res = await createShortLinks(this.formData)\n          break\n      }\n      if (res.code === 0) {\n        this.$message({\n          type: 'success',\n          message: '创建/更改成功'\n        })\n        this.closeDialog()\n        this.getTableData()\n      }\n    },\n    openDialog() {\n      this.type = 'create'\n      this.dialogFormVisible = true\n    }\n  },\n}\n\u003c/script\u003e\n\n\u003cstyle\u003e\n\u003c/style\u003e\n\n\n```"
        }
    },
    "msg":"预览成功"
}
````
