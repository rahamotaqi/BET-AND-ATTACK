veTo(y, x);
        },
        closePath: function() {
            this._context.closePath();
        },
        lineTo: function(x, y) {
            this._context.lineTo(y, x);
        },
        bezierCurveTo: function(x1, y1, x2, y2, x, y) {
            this._context.bezierCurveTo(y1, x1, y2, x2, y, x);
        }
    };
}, function(module, __webpack_exports__, __webpack_require__) {
    "use strict";
    function Natural(context) {
        this._context = context;
    }
    function controlPoints(x) {
        var i, m, n = x.length - 1, a = new Array(n), b = new Array(n), r = new Array(n);
        for (a[0] = 0, b[0] = 2, r[0] = x[0] + 2 * x[1], i = 1; i < n - 1; ++i) a[i] = 1, 
        b[i] = 4, r[i] = 4 * x[i] + 2 * x[i + 1];
        for (a[n - 1] = 2, b[n - 1] = 7, r[n - 1] = 8 * x[n - 1] + x[n], i = 1; i < n; ++i) m = a[i] / b[i - 1], 
        b[i] -= m, r[i] -= m * r[i - 1];
        for (a[n - 1] = r[n - 1] / b[n - 1], i = n - 2; i >= 0; --i) a[i] = (r[i] - a[i + 1]) / b[i];
        for (b[n - 1] = (x[n] + a[n - 1]) / 2, i = 0; i < n - 1; ++i) b[i] = 2 * x[i + 1] - a[i + 1];
        return [ a, b ];
    }
    Natural.prototype = {
        areaStart: function() {
            this._line = 0;
        },
        areaEnd: function() {
            this._line = NaN;
        },
        lineStart: function() {
            this._x = [], this._y = [];
        },
        lineEnd: function() {
            var x = this._x, y = this._y, n = x.length;
            if (n) if (this._line ? this._context.lineTo(x[0], y[0]) : this._context.moveTo(x[0], y[0]), 
            2 === n) this._context.lineTo(x[1], y[1]); else for (var px = controlPoints(x), py = controlPoints(y), i0 = 0, i1 = 1; i1 < n; ++i0, 
            ++i1) this._context.bezierCurveTo(px[0][i0], py[0][i0], px[1][i0], py[1][i0], x[i1], y[i1]);
            (this._line || 0 !== this._line && 1 === n) && this._context.closePath(), this._line = 1 - this._line, 
            this._x = this._y = null;
        },
        point: function(x, y) {
            this._x.push(+x), this._y.push(+y);
        }
    }, __webpack_exports__.a = function(context) {
        return new Natural(context);
    };
}, function(module, __webpack_exports__, __webpack_require__) {
    "use strict";
    function Step(context, t) {
        this._context = context, this._t = t;
    }
    function stepBefore(context) {
        return new Step(context, 0);
    }
    function stepAfter(context) {
        return new Step(context, 1);
    }
    __webpack_exports__.c = stepBefore, __webpack_exports__.b = stepAfter, Step.prototype = {
        areaStart: function() {
            this._line = 0;
        },
        areaEnd: function() {
            this._line = NaN;
        },
        lineStart: function() {
            this._x = this._y = NaN, this._point = 0;
        },
        lineEnd: function() {
            0 < this._t && this._t < 1 && 2 === this._point && this._context.lineTo(this._x, this._y), 
            (this._line || 0 !== this._line && 1 === this._point) && this._context.closePath(), 
            this._line >= 0 && (this._t = 1 - this._t, this._line = 1 - this._line);
        },
        point: function(x, y) {
            switch (x = +x, y = +y, this._point) {
              case 0:
                this._point = 1, this._line ? this._context.lineTo(x, y) : this._context.moveTo(x, y);
                break;

              case 1:
                this._point = 2;

              default:
                if (this._t <= 0) this._context.lineTo(this._x, y), this._context.lineTo(x, y); else {
                    var x1 = this._x * (1 - this._t) + x * this._t;
                    this._context.lineTo(x1, this._y), this._context.lineTo(x1, y);
                }
            }
            this._x = x, this._y = y;
        }
    }, __webpack_exports__.a = function(context) {
        return new Step(context, .5);
    };
}, function(module, __webpack_exports__, __webpack_require__) {
    "use strict";
    function stackValue(d, key) {
        return d[key];
    }
    var __WEBPACK_IMPORTED_MODULE_0__array__ = __webpack_require__(277), __WEBPACK_IMPORTED_MODULE_1__constant__ = __webpack_require__(58), __WEBPACK_IMPORTED_MODULE_2__offset_none__ = __webpack_require__(86), __WEBPACK_IMPORTED_MODULE_3__order_none__ = __webpack_require__(87);
    __webpack_exports__.a = function() {
        function stack(data) {
            var i, oz, kz = keys.apply(this, arguments), m = data.length, n = kz.length, sz = new Array(n);
            for (i = 0; i < n; ++i) {
                for (var sij, ki = kz[i], si = sz[i] = new Array(m), j = 0; j < m; ++j) si[j] = sij = [ 0, +value(data[j], ki, j, data) ], 
                sij.data = data[j];
                si.key = ki;
            }
            for (i = 0, oz = order(sz); i < n; ++i) sz[oz[i]].index = i;
            return offset(sz, oz), sz;
        }
        var keys = Object(__WEBPACK_IMPORTED_MODULE_1__constant__.a)([]), order = __WEBPACK_IMPORTED_MODULE_3__order_none__.a, offset = __WEBPACK_IMPORTED_MODULE_2__offset_none__.a, value = stackValue;
        return stack.keys = function(_) {
            return arguments.length ? (keys = "function" == typeof _ ? _ : Object(__WEBPACK_IMPORTED_MODULE_1__constant__.a)(__WEBPACK_IMPORTED_MODULE_0__array__.a.call(_)), 
            stack) : keys;
        }, stack.value = function(_) {
            return arguments.length ? (value = "function" == typeof _ ? _ : Object(__WEBPACK_IMPORTED_MODULE_1__constant__.a)(+_), 
            stack) : value;
        }, stack.order = function(_) {
            return arguments.length ? (order = null == _ ? __WEBPACK_IMPORTED_MODULE_3__order_none__.a : "function" == typeof _ ? _ : Object(__WEBPACK_IMPORTED_MODULE_1__constant__.a)(__WEBPACK_IMPORTED_MODULE_0__array__.a.call(_)), 
            stack) : order;
        }, stack.offset = function(_) {
            return arguments.length ? (offset = null == _ ? __WEBPACK_IMPORTED_MODULE_2__offset_none__.a : _, 
            stack) : offset;
        }, stack;
    };
}, function(module, __webpack_exports__, __webpack_require__) {
    "use strict";
    var __WEBPACK_IMPORTED_MODULE_0__none__ = __webpack_require__(86);
    __webpack_exports__.a = function(series, order) {
        if ((n = series.length) > 0) {
            for (var i, n, y, j = 0, m = series[0].length; j < m; ++j) {
                for (y = i = 0; i < n; ++i) y += series[i][j][1] || 0;
                if (y) for (i = 0; i < n; ++i) series[i][j][1] /= y;
            }
            Object(__WEBPACK_IMPORTED_MODULE_0__none__.a)(series, order);
        }
    };
}, function(module, __webpack_exports__, __webpack_require__) {
    "use strict";
}, function(module, __webpack_exports__, __webpack_require__) {
    "use strict";
    var __WEBPACK_IMPORTED_MODULE_0__none__ = __webpack_require__(86);
    __webpack_exports__.a = function(series, order) {
        if ((n = series.length) > 0) {
            for (var n, j = 0, s0 = series[order[0]], m = s0.length; j < m; ++j) {
                for (var i = 0, y = 0; i < n; ++i) y += series[i][j][1] || 0;
                s0[j][1] += s0[j][0] = -y / 2;
            }
            Object(__WEBPACK_IMPORTED_MODULE_0__none__.a)(series, order);
        }
    };
}, function(module, __webpack_exports__, __webpack_require__) {
    "use strict";
    var __WEBPACK_IMPORTED_MODULE_0__none__ = __webpack_require__(86);
    __webpack_exports__.a = function(series, order) {
        if ((n = series.length) > 0 && (m = (s0 = series[order[0]]).length) > 0) {
            for (var s0, m, n, y = 0, j = 1; j < m; ++j) {
                for (var i = 0, s1 = 0, s2 = 0; i < n; ++i) {
                    for (var si = series[order[i]], sij0 = si[j][1] || 0, sij1 = si[j - 1][1] || 0, s3 = (sij0 - sij1) / 2, k = 0; k < i; ++k) {
                        var sk = series[order[k]];
                        s3 += (sk[j][1] || 0) - (sk[j - 1][1] || 0);
                    }
                    s1 += sij0, s2 += s3 * sij0;
                }
                s0[j - 1][1] += s0[j - 1][0] = y, s1 && (y -= s2 / s1);
            }
            s0[j - 1][1] += s0[j - 1][0] = y, Object(__WEBPACK_IMPORTED_MODULE_0__none__.a)(series, order);
        }
    };
}, function(module, __webpack_exports__, __webpack_require__) {
    "use strict";
    __webpack_require__(186);
}, function(module, __webpack_exports__, __webpack_require__) {
    "use strict";
    __webpack_require__(87), __webpack_require__(186);
}, function(module, __webpack_exports__, __webpack_require__) {
    "use strict";
    __webpack_require__(87);
}, function(module, exports, __webpack_require__) {
    function baseIsEqualDeep(object, other, bitmask, customizer, equalFunc, stack) {
        var objIsArr = isArray(object), othIsArr = isArray(other), objTag = objIsArr ? arrayTag : getTag(object), othTag = othIsArr ? arrayTag : getTag(other);
        objTag = objTag == argsTag ? objectTag : objTag, othTag = othTag == argsTag ? objectTag : othTag;
        var objIsObj = objTag == objectTag, othIsObj = othTag == objectTag, isSameTag = objTag == othTag;
        if (isSameTag && isBuffer(object)) {
            if (!isBuffer(other)) return !1;
            objIsArr = !0, objIsObj = !1;
        }
        if (isSameTag && !objIsObj) return stack || (stack = new Stack()), objIsArr || isTypedArray(object) ? equalArrays(object, other, bitmask, customizer, equalFunc, stack) : equalByTag(object, other, objTag, bitmask, customizer, equalFunc, stack);
        if (!(bitmask & COMPARE_PARTIAL_FLAG)) {
            var objIsWrapped = objIsObj && hasOwnProperty.call(object, "__wrapped__"), othIsWrapped = othIsObj && hasOwnProperty.call(other, "__wrapped__");
            if (objIsWrapped || othIsWrapped) {
                var objUnwrapped = objIsWrapped ? object.value() : object, othUnwrapped = othIsWrapped ? other.value() : other;
                return stack || (stack = new Stack()), equalFunc(objUnwrapped, othUnwrapped, bitmask, customizer, stack);
            }
        }
        return !!isSameTag && (stack || (stack = new Stack()), equalObjects(object, other, bitmask, customizer, equalFunc, stack));
    }
    var Stack = __webpack_require__(289), equalArrays = __webpack_require__(294), equalByTag = __webpack_require__(689), equalObjects = __webpack_require__(693), getTag = __webpack_require__(708), isArray = __webpack_require__(34), isBuffer = __webpack_require__(299), isTypedArray = __webpack_require__(301), COMPARE_PARTIAL_FLAG = 1, argsTag = "[object Arguments]", arrayTag = "[object Array]", objectTag = "[object Object]", objectProto = Object.prototype, hasOwnProperty = objectProto.hasOwnProperty;
    module.exports = baseIsEqualDeep;
}, function(module, exports) {
    function listCacheClear() {
        this.__data__ = [], this.size = 0;
    }
    module.exports = listCacheClear;
}, function(module, exports, __webpack_require__) {
    function listCacheDelete(key) {
        var data = this.__data__, index = assocIndexOf(data, key);
        return !(index < 0) && (index == data.length - 1 ? data.pop() : splice.call(data, index, 1), 
        --this.size, !0);
    }
    var assocIndexOf = __webpack_require__(127), arrayProto = Array.prototype, splice = arrayProto.splice;
    module.exports = listCacheDelete;
}, function(module, exports, __webpack_r