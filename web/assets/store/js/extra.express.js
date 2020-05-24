(function () {

    // 配置信息
    var setting = {
        el: 'many-app',
        baseData: null
    };

    /**
     * 构造方法
     * @param options
     * @param baseData
     * @constructor
     */
    function ExtraExpress(options, baseData) {
        // 配置信息
        setting = $.extend(true, {}, setting, options);
        // 初始化
        this.initialize();
    }

    ExtraExpress.prototype = {

        // vue组件句柄
        appVue: null,

        /**
         * 初始化
         */
        initialize: function () {

            // 实例化vue对象
            this.appVue = new Vue({
                el: setting.el,
                data: {
                    extra_express: []
                },
                methods: {
                    /**
                     * 增加物流信息
                     */
                    addExpress: function () {
                        var base = {express_id: '', express_no:'', express_goods:''};
                        this.$data.extra_express.push(base);
                    },

                    /**
                     * 删除物流信息
                     */
                    deleteExpress: function (index) {
                        this.extra_express.splice(index,1);
                    },

                    /**
                     * 删除物流信息
                     */
                    reset: function (index) {
                        this.extra_express = [];
                    },

                    /**
                     * 获取当前data
                     */
                    getData: function () {
                        return this.$data;
                    },

                    /**
                     * 物流信息列表是否为空
                     * @returns {boolean}
                     */
                    isEmptyExpress: function () {
                        return !this.extra_express.length;
                    }

                }
            });
        }

    };

    window.ExtraExpress = ExtraExpress;

})();

