//========================================================
//      支持webgl绘制批量提交
//      王召伟
//      rtx:eldwinwang
//      2018-03-21
//========================================================

var commonstring = "";
var currentctxid = 0;
var webglObjects = new Array();

function __getCommonString__() {
    return commonstring;
}

function __clearCommonString__() {
    webglObjects.splice(0);
    commonstring = "";
}

function __resetRenderingContext__(){
    currentctxid = 0;
}

function checkContextChange(ctxid, webgl)
{
    if (currentctxid != ctxid) {
        commonstring = commonstring  + ';999,' + ctxid + ',' + webgl;
        currentctxid = ctxid;
    }
}

var __getWebGLContext__ = function(origin_ctx){
    commonstring = "";
    var batchGL = {
        batchRender: function (sync) {
            var r = commandRender(commonstring, sync);
            commonstring = "";
            return r;
        },
        vertexAttribPointer:function(a,b,c,d,e,f){
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';1,6,' + a + ',' + b + ',' + c + ',' + (d?1:0) + ',' + e + ',' + f;
        },
        activeTexture: function (a) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';2,1,' + a;
        },
        uniform1i: function (a, b) {
            checkContextChange(this.ctxid, 1);
            if(typeof b === 'boolean') b = b?1:0;
            commonstring = commonstring  + ';3,2,' + a.id + ',' + b;
        },
        drawElements: function (a, b, c, d) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';4,4,' + a + ',' + b + ',' + c + ',' + d;
        },
        bindBuffer: function (target, buffer) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';5,2,' + target + ',' + (buffer ? buffer.id : 0);
        },
        bindTexture: function (target, texture) {
            checkContextChange(this.ctxid, 1);
            var tex = (texture == null) ? 0 : texture.uid;
            commonstring = commonstring  + ';6,2,' + target + ',' + tex;
        },
        uniformMatrix4fv: function (a, b, c) {
            checkContextChange(this.ctxid, 1);
            if (ArrayBuffer.isView(c) || Array.isArray(c)) {
                commonstring = commonstring  + ';7,3,' + a.id + ',' + (b ? 1 : 0) + ',' + c.length + ',14,' + c;
            }
            else {
                var v = new Uint32Array(c);
                commonstring = commonstring  + ';7,3,' + a.id + ',' + (b ? 1 : 0) + ',' + v.length + ',4,' + v;
            }
        },
        viewport: function (a, b, c, d) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';8,4,' + a + ',' + b + ',' + c + ',' + d;
        },
        clear: function (param) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';9,1,' + param;
        },
        createProgram: function () {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';10';
            var program = {};
            program.id = this.batchRender(true);
            this._map.set('Program-'+program.id, program);
            return program;
        },
        createShader: function (shaderType) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';11,1,' + shaderType;
            var shader = {};
            shader.id = this.batchRender(true);
            this._map.set('Shader-'+shader.id, shader);
            return shader;
        },
        shaderSource: function (shader, source) {
            checkContextChange(this.ctxid, 1);
            var len = getUtf8Length(source);
            commonstring = commonstring  + ';12,2,' + shader.id + ',' + len + ',' + source;
        },
        getShaderInfoLog: function (shader) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';13,1,' + shader.id;
            return this.batchRender(true);
        },
        getShaderParameter: function (shader, pname) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';14,2,' + shader.id + ',' + pname;
            return this.batchRender(true);
        },
        compileShader: function (shader) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';15,1,' + shader.id;
        },
        attachShader: function (program, shader) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';16,2,' + program.id + ',' + shader.id;
        },
        linkProgram: function (program) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';17,1,' + program.id;
        },
        getProgramParameter: function (program, pname) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';18,2,' + program.id + ',' + pname;
            return this.batchRender(true);
        },
        useProgram: function (program) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';19,1,' + program.id;
        },
        getAttribLocation: function (program, name) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';20,2,' + program.id + ',' + name.length + ',' + name;
            return this.batchRender(true);
        },
        enableVertexAttribArray: function (index) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';21,1,' + index;
        },
        getUniformLocation: function (program, name) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';22,2,' + program.id + ',' + name.length + ',' + name;
            var location = {};
            location.id = this.batchRender(true);
            return location;
        },
        createBuffer: function () {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';23';
            var buffer = {};
            buffer.id = this.batchRender(true);
            this._map.set('Buffer-'+buffer.id, buffer);
            return buffer;
        },
        bufferData: function (a, b, c) {
            checkContextChange(this.ctxid, 1);
            var v;
            if(typeof b === 'number' && !isNaN(b))
            {
                commonstring = commonstring  + ';24,3,' + a + ',-1,' + b + ',' + c;
            }
            else{
                var bufferId = this.origin_ctx.setArrayBuffer(b);
                commonstring = commonstring  + ';24,3,' + a + ',' + bufferId + ',' + c;
            }
        },
        createTexture: function () {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';25';
            var texture = this.batchRender(true);
            texture.uid = texture.__id();
            return texture;
        },
        pixelStorei: function (a, b) {
            checkContextChange(this.ctxid, 1);
            if(typeof b === 'boolean') b = b?1:0;
            commonstring = commonstring  + ';26,2,' + a + ',' + b;
        },
        texImage2D: function (a, b, c, d, e, f, g, h, i) {
            checkContextChange(this.ctxid, 1);
            var argc = arguments.length;
            if(argc == 6){
                commonstring = commonstring  + ';27,6,' + a + ',' + b + ',' + c + ',' + d + ',' + e + ',' + f.uid;
            }
            else if(argc == 9){
                if (i==null) {
                    commonstring = commonstring  + ';27,9,' + a + ',' + b + ',' + c + ',' + d + ',' + e + ',' + f + ',' + g + ',' + h + ',0';
                }
                else{
                    var v = new Uint32Array(i);
                    commonstring = commonstring  + ';27,9,' + a + ',' + b + ',' + c + ',' + d + ',' + e + ',' + f + ',' + g + ',' + h + ',' + v.length + ',4,' + v;
                }
            }
            this.batchRender(false);
        },
        texParameteri: function (a, b, c) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';28,3,' + a + ',' + b + ',' + c;
        },
        enable: function (param) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';29,1,' + param;
        },
        clearColor: function (a, b, c, d) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';30,4,' + a + ',' + b + ',' + c + ',' + d;
        },
        disable: function (param) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';31,1,' + param;
        },
        getExtension: function (name) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';32,1,' + name.length + ',' + name;
            var ext = this.batchRender(true);
            if(name == "ANGLE_instanced_arrays"){
                var extension = {
                    drawArraysInstancedANGLE:function(mode, first, count, instanceCount){
                        checkContextChange(this.ctxid, 1);
                        commonstring = commonstring  + ';138,4,' + mode+ ',' +first+ ',' +count+ ',' +instanceCount;
                    },
                    drawElementsInstancedANGLE:function(mode, first, type, indice, instanceCount){
                        checkContextChange(this.ctxid, 1);
                        commonstring = commonstring  + ';139,5,' + mode+ ',' +first+ ',' + type + ',' + indice + ',' +instanceCount;
                    },
                    vertexAttribDivisorANGLE:function(index, divisor){
                        checkContextChange(this.ctxid, 1);
                        commonstring = commonstring  + ';140,2,' + index+ ',' +divisor;
                    },
                };
                extensionctxid = this.ctxid;
                extension.VERTEX_ATTRIB_ARRAY_DIVISOR_ANGLE = ext.VERTEX_ATTRIB_ARRAY_DIVISOR_ANGLE;
            }
            else if(name == "OES_vertex_array_object"){
                return null;
            }
            else{
                extension = ext;
            }
            return extension;
        },
        getParameter: function (pname) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';33,1,' + pname;
            const ret = this.batchRender(true);
            switch (pname) {
            case batchGL.ARRAY_BUFFER_BINDING: // buffer
            case batchGL.ELEMENT_ARRAY_BUFFER_BINDING: // buffer
            return this._map.get('Buffer-' + ret) || null;
            case batchGL.CURRENT_PROGRAM: // program
            return this._map.get('Program-' + ret) || null;
            case batchGL.FRAMEBUFFER_BINDING: // framebuffer
            return this._map.get('Framebuffer-' + ret) || null;
            case batchGL.RENDERBUFFER_BINDING: // renderbuffer
            return this._map.get('Renderbuffer-' + ret) || null;
            default:
            return ret;
        }
    },
    getSupportedExtensions: function () {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';34';
        return this.batchRender(true);
    },
    blendFunc: function (s,d) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';35,2,' + s + ',' + d;
    },
    getShaderPrecisionFormat: function (s,d) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';36,2,' + s + ',' + d;
        const resultString = this.batchRender(true);
        const arr = resultString.split(',');
        var shaderPrecisionFormat = {};
        shaderPrecisionFormat.rangeMin = arr[0];;
        shaderPrecisionFormat.rangeMax = arr[1];
        shaderPrecisionFormat.precision = arr[2];
        return shaderPrecisionFormat;
    },
    bindAttribLocation: function (program, index, name) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';37,3,' + program.id + ',' + index + ',' + name.length + ',' + name;
    },
    deleteShader: function (shader) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';38,1,' + shader.id;
        webglObjects.push(shader);
    },
    drawArrays: function (a,b,c) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';39,3,' + a + ',' + b + ',' + c;
    },
    isEnabled: function (param) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';40,1,' + param;
        return this.batchRender(true);
    },
    depthMask: function (param) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';41,1,' + (param?1:0);
    },
    stencilFunc: function (a,b,c) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';42,3,'+ a + ',' + b + ',' + c;;
    },
    stencilOp: function (a,b,c) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';43,3,'+ a + ',' + b + ',' + c;;
    },
    stencilMask: function (param) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';44,1,' + param;
    },
    scissor: function (a, b, c, d) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';45,4,' + a + ',' + b + ',' + c + ',' + d;
    },
    bufferSubData: function(a, b,c){
        checkContextChange(this.ctxid, 1);
        var bufferId = this.origin_ctx.setArrayBuffer(c);
        commonstring = commonstring  + ';46,3,' + a + ',' + b + ',' + bufferId;
    },
    blendFuncSeparate: function (a,b,c,d) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';47,4,' + a + ',' + b + ',' + c + ',' + d;
    },
    uniform1f: function (a, b) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';48,2,' + a.id + ',' + b;
    },
    clearDepth: function (a) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';49,1,' + a;
    },
    clearStencil: function (a) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';50,1,' + a;
    },
    depthFunc: function (a) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';51,1,' + a;
    },
    frontFace: function (a) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';52,1,' + a;
    },
    cullFace: function (a) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';53,1,' + a;
    },
    blendEquationSeparate: function (a,b) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';54,2,' + a + ',' + b;
    },
    createFramebuffer: function () {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';55';
        var framebuffer = {};
        framebuffer.id = this.batchRender(true);
        this._map.set('Framebuffer-'+framebuffer.id, framebuffer);
        return framebuffer;
    },
    bindFramebuffer: function (target, framebuffer) {
        checkContextChange(this.ctxid, 1);
        //framebuffer为null时，返回-1，EJecta对-1特殊处理
        commonstring = commonstring  + ';56,2,' + target + ',' + (framebuffer ? framebuffer.id : -1);
    },
    framebufferTexture2D: function (target, attachment, textarget, texture, level) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';57,5,' + target + ',' + attachment + ',' + textarget + ',' + texture.uid + ',' + level;
    },
    createRenderbuffer: function () {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';58';
        var renderBuffer = {};
        renderBuffer.id = this.batchRender(true);
        this._map.set('Renderbuffer-'+renderBuffer.id, renderBuffer);
        return renderBuffer;
    },
    bindRenderbuffer: function (target, renderbuffer) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';59,2,' + target + ',' + (renderbuffer ? renderbuffer.id : 0);
    },
    renderbufferStorage: function (a, b, c, d) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';60,4,' + a + ',' + b + ',' + c + ',' + d;
    },
    framebufferRenderbuffer: function (target, attachment, renderbuffertarget, renderbuffer) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';61,4,' + target + ',' + attachment + ',' + renderbuffertarget + ',' + (renderbuffer ? renderbuffer.id : 0);
    },
    colorMask: function (a, b, c, d) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';62,4,' + (a?1:0) + ',' + (b?1:0) + ',' + (c?1:0) + ',' + (d?1:0);
    },
    getProgramInfoLog: function (program){
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';63,1,' + program.id;
        return this.batchRender(true);
    },
    getActiveAttrib: function (program, index) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';64,2,' + program.id + ',' + index;
        const resultString = this.batchRender(true);
        const arr = resultString.split(',');
        var activeInfo = {};
        activeInfo.type = Number(arr[0]);
        activeInfo.size = Number(arr[1]);
        activeInfo.name = arr[2];
        return  activeInfo;
    },
    getActiveUniform: function (program, index) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';65,2,' + program.id + ',' + index;
        const resultString = this.batchRender(true);
        const arr = resultString.split(',');
        var activeInfo = {};
        activeInfo.type = Number(arr[0]);
        activeInfo.size = Number(arr[1]);
        activeInfo.name = arr[2];
        return  activeInfo;
    },
    uniform3f: function (a, b, c, d) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';66,4,' + a.id + ',' + b + ',' + c + ',' + d;
    },
    uniform1iv: function (a, b) {
        checkContextChange(this.ctxid, 1);
        if (ArrayBuffer.isView(b)|| Array.isArray(b)) {
            commonstring = commonstring  + ';67,2,' + a.id + ',' + b.length + ',4,' + b;
        }
        else {
            var v = new Uint32Array(b);
            commonstring = commonstring  + ';67,2,' + a.id + ',' + v.length + ',4,' + v;
        }
    },
    uniform3fv: function (a, b) {
        checkContextChange(this.ctxid, 1);
        if (ArrayBuffer.isView(b)|| Array.isArray(b)) {
            commonstring = commonstring  + ';68,2,' + a.id + ',' + b.length + ',14,' + b;
        }
        else {
            var v = new Uint32Array(b);
            commonstring = commonstring  + ';68,2,' + a.id + ',' + v.length + ',4,' + v;
        }
    },
    uniform2f: function (a, b, c) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';69,3,' + a.id + ',' + b + ',' + c;
    },
    uniformMatrix3fv: function (a, b, c) {
        checkContextChange(this.ctxid, 1);
        if (ArrayBuffer.isView(c) || Array.isArray(c)) {
            commonstring = commonstring  + ';70,3,' + a.id + ',' + (b ? 1 : 0) + ',' + c.length + ',14,' + c;
        }
        else {
            var v = new Uint32Array(c);
            commonstring = commonstring  + ';70,3,' + a.id + ',' + (b ? 1 : 0) + ',' + v.length + ',4,' + v;
        }
    },
    disableVertexAttribArray: function (a) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';71,1,' + a;
    },
    generateMipmap: function (a) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';72,1,' + a;
    },
    uniform4fv: function (a, b) {
        checkContextChange(this.ctxid, 1);
        if (ArrayBuffer.isView(b)|| Array.isArray(b)) {
            commonstring = commonstring  + ';73,2,' + a.id + ',' + b.length + ',14,' + b;
        }
        else {
            var v = new Uint32Array(b);
            commonstring = commonstring  + ';73,2,' + a.id + ',' + v.length + ',4,' + v;
        }
    },
    getError: function () {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';74';
        return this.batchRender(true);
    },
    deleteTexture: function (texture) {
        checkContextChange(this.ctxid, 1);
        var tex = (texture == null) ? 0 : texture.uid;
        commonstring = commonstring  + ';75,1,' + tex;
        webglObjects.push(texture);
    },
    deleteBuffer: function (buffer) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';76,1,' + (buffer ? buffer.id : 0);
        webglObjects.push(buffer);
    },
    getShaderSource: function (shader) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';77,1,' + (shader ? shader.id:0);
        return this.batchRender(true);
    },
    deleteProgram: function (program) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';78,1,' + (program ? program.id : 0);
        webglObjects.push(program);
    },
    deleteFramebuffer: function (framebuffer) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';79,1,' + (framebuffer?framebuffer.id:0);
        webglObjects.push(framebuffer);
    },
    deleteRenderbuffer: function (renderbuffer) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';80,1,' + (renderbuffer?renderbuffer.id:0);
        webglObjects.push(renderbuffer);
    },
    texSubImage2D: function (a, b, c, d, e, f, g, h, i) {
        checkContextChange(this.ctxid, 1);
        var argc = arguments.length;
        if(argc == 7){
            commonstring = commonstring  + ';81,7,' + a + ',' + b + ',' + c + ',' + d + ',' + e + ',' + f + ',' + g.uid;
        }
        else if(argc == 9){
            if (i==null) {
                commonstring = commonstring  + ';81,9,' + a + ',' + b + ',' + c + ',' + d + ',' + e + ',' + f + ',' + g + ',' + h + ',0';
            }
            else{
                var v = new Uint32Array(i);
                commonstring = commonstring  + ';81,9,' + a + ',' + b + ',' + c + ',' + d + ',' + e + ',' + f + ',' + g + ',' + h + ',' + v.length + ',4,' + v;
            }
        }
        this.batchRender(false);
    },
    uniform4f: function (a, b, c, d, e) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';82,5,' + a.id + ',' + b + ',' + c + ',' + d + ',' + e;
    },
    isBuffer: function (buffer) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';83,1,' + buffer.id;
        return this.batchRender(true);
    },
    isContextLost: function () {
        return false;
    },
    isFramebuffer: function (framebuffer) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';85,1,' + framebuffer.id;
        return this.batchRender(true);
    },
    isProgram: function (program) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';86,1,' + program.id;
        return this.batchRender(true);
    },
    isRenderbuffer: function (renderBuffer) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';87,1,' + renderBuffer.id;
        return this.batchRender(true);
    },
    isShader: function (shader) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';88,1,' + shader.id;
        return this.batchRender(true);
    },
    isTexture: function (texture) {
        checkContextChange(this.ctxid, 1);
        var tex = (texture == null) ? 0 : texture.uid;
        commonstring = commonstring  + ';89,1,' + tex;
        return this.batchRender(true);
    },
    uniform2i: function (location, v0, v1) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';90,3,' + location.id + ',' + v0 + ',' + v1;
    },
    uniform3i: function (location, v0, v1, v2) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';91,4,' + location.id + ',' + v0 + ',' + v1 + ',' + v2;
    },
    uniform4i: function (location, v0, v1, v2, v3) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';92,4,' + location.id + ',' + v0 + ',' + v1 + ',' + v2 + ',' + v3;
    },
    uniform1fv: function (location, value) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';93,2,' + location.id + ',' + value.length + ',14,' + value;
    },
    uniform2fv: function (location, value) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';94,2,' + location.id + ',' + value.length + ',14,' + value;
    },
    uniform2iv: function (location, value) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';95,2,' + location.id + ',' + value.length + ',4,' + value;
    },
    uniform3iv: function (location, value) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';96,2,' + location.id + ',' + value.length + ',4,' + value;
    },
    uniform4iv: function (location, value) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';97,2,' + location.id + ',' + value.length + ',4,' + value;
    },
    uniformMatrix2fv: function (location, transpose, value) {
        checkContextChange(this.ctxid, 1);
        if (ArrayBuffer.isView(value) || Array.isArrayvalue) {
            commonstring = commonstring  + ';98,3,' + location.id + ',' + Number(transpose) + ',' + value.length + ',14,' + value;
        }
        else {
            var v = new Uint32Array(c);
            commonstring = commonstring  + ';98,3,' + location.id + ',' + Number(transpose) + ',' + value.length + ',4,' + value;
        }
    },
    vertexAttrib1f: function (index, v0) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';99,2,' + index + ',' + v0;
    },
    vertexAttrib2f: function (index, v0, v1) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';100,3,' + index + ',' + v0 + ',' + v1;
    },
    vertexAttrib3f: function (index, v0, v1, v2) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';101,4,' + index + ',' + v0 + ',' + v1 + ',' + v2;
    },
    vertexAttrib4f: function (index, v0, v1, v2, v3) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';102,5,' + index + ',' + v0 + ',' + v1 + ',' + v2 + ',' + v3;
    },
    vertexAttrib1fv: function (index, value) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';103,2,' + index + ',' + value.length + ',14' + value;
    },
    vertexAttrib2fv: function (index, value) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';104,2,' + index + ',' + value.length + ',14' + value;
    },
    vertexAttrib3fv: function (index, value) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';105,2,' + index + ',' + value.length + ',14' + value;
    },
    vertexAttrib4fv: function (index, value) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';106,2,' + index + ',' + value.length + ',14' + value;
    },
    blendColor: function (r, g, b, a) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';107,4,' + r + ',' + g + ',' + b + ',' + a;
    },
    checkFramebufferStatus: function (target) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';108,1,' + target;
        return this.batchRender(true);
    },
    compressedTexImage2D: function (target, level, internalformat, width, height, border, pixels) {
        checkContextChange(this.ctxid, 1);
        this.batchRender(false);
        this.origin_ctx.compressedTexImage2D(target, level, internalformat, width, height, border, pixels);
    },
    compressedTexSubImage2D: function (target, level, xoffset, yoffset, width, height, format, pixels) {
        checkContextChange(this.ctxid, 1);
        this.batchRender(false);
        this.origin_ctx.compressedTexSubImage2D(target, level, xoffset, yoffset, width, height, format, pixels);
    },
    copyTexImage2D: function (target, level, internalformat, x, y, width, height, border) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';111,8,' + target + ',' + level + ',' + internalformat + ',' + x + ',' + y + ',' + width + ',' + height + ',' + border;
    },
    copyTexSubImage2D: function (target, level, xoffset, yoffset, x, y, width, height) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';112,8,' + target + ',' + level + ',' + xoffset + ',' + yoffset + ',' + x + ',' + y + ',' + width + ',' + height;
    },
    depthRange: function (zNear, zFar) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';113,2,' + zNear + ',' + zFar;
    },
    detachShader: function (program, shader) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';114,2,' + program.id + ',' + shader.id;
    },
    flush: function () {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';115';
        this.batchRender(false);
    },
    finish: function () {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';116';
        this.batchRender(false);
    },
    hint: function (target, mode) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';117,2,' + target + ',' + mode;
    },
    lineWidth: function (width) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';118,1,' + width;
    },
    polygonOffset: function (factor, units) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';119,2,' + factor + ',' + units;
    },
    sampleCoverage: function (value, invert) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';120,2,' + value + ',' + (invert ? 1 : 0);
    },
    stencilFuncSeparate: function (face, func, ref, mask) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';121,4,' + face + ',' + func + ',' + ref + ',' + mask;
    },
    stencilMaskSeparate: function (face, mask) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';122,2,' + face + ',' + mask;
    },
    stencilOpSeparate: function (face, fail, zfail, zpass) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';123,4,' + face + ',' + fail + ',' + zfail + ',' + zpass;
    },
    texParameterf: function (target, pname, param) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';124,3,' + target + ',' + pname + ',' + param;
    },
    validateProgram: function (program) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';125,1,' + program.id;
    },
    
    getBufferParameter: function (target, pname) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';126,2,' + target + ',' + pname;
        return this.batchRender(true);
    },
    getRenderbufferParameter: function (target, pname) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';127,2,' + target + ',' + pname;
        return this.batchRender(true);
    },
    getTexParameter: function (target, pname) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';128,2,' + target + ',' + pname;
        return this.batchRender(true);
    },
    getVertexAttribOffset: function (index, pname) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';129,2,' + index + ',' + pname;
        return this.batchRender(true);
    },
    wxSetContextAttributes: function (dic) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';130,2,' + dic.antialias + ',' + dic.antialiasSamples;
    },
    wxBindCanvasTexture: function (target, canvas) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';131,2,' + target + ',' + canvas.uid;
    },
    getContextAttributes: function (t) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';132';
        return this.batchRender(true);
    },
    readPixels: function (x, y, width, height, format, type, pixels) {
        checkContextChange(this.ctxid, 1);
        //133
        this.batchRender(false);
        return this.origin_ctx.readPixels(x, y, width, height, format, type, pixels);
    },
    getAttachedShaders: function (progarm) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';134,1,' + progarm.id;
        const resultString = this.batchRender(true);
        var arr = resultString.split(',');
        for(i = 0,len=arr.length; i < len; i++) {
            arr[i] = this._map.get('Shader-' + arr[i]);
        }
        return arr;
    },
    getFramebufferAttachmentParameter: function (target, attachment, pname) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';135,3,' + target + ',' + attachment + ',' + pname;
        const result = this.batchRender(true);
        switch (pname) {
            case batchGL.FRAMEBUFFER_ATTACHMENT_OBJECT_NAME:
            return this._map.get('Renderbuffer-' + result) || null;
            default:
            return result;
        }
    },
    getVertexAttrib: function (index, pname) {
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';136,2,' + index + ',' + pname;
        const result = this.batchRender(true);
        switch (pname) {
            case batchGL.VERTEX_ATTRIB_ARRAY_BUFFER_BINDING:
            return this._map.get('Buffer-' + result) || null;
            default:
            return result;
        }
    },
    blendEquation: function (mode){
        checkContextChange(this.ctxid, 1);
        commonstring = commonstring  + ';137,1,' + mode;
    },
    
    /////////////////////////////////////////////////////
};

    // batchGL.FRAGMENT_SHADER = origin_ctx.FRAGMENT_SHADER;
    // batchGL.COMPILE_STATUS = origin_ctx.COMPILE_STATUS;
    // batchGL.VERTEX_SHADER = origin_ctx.VERTEX_SHADER;
    // batchGL.LINK_STATUS = origin_ctx.LINK_STATUS;
    // batchGL.TEXTURE_2D = origin_ctx.TEXTURE_2D;
    // batchGL.UNPACK_FLIP_Y_WEBGL = origin_ctx.UNPACK_FLIP_Y_WEBGL;
    // batchGL.RGBA = origin_ctx.RGBA;
    // batchGL.UNSIGNED_BYTE = origin_ctx.UNSIGNED_BYTE;
    // batchGL.TEXTURE_MAG_FILTER = origin_ctx.TEXTURE_MAG_FILTER;
    // batchGL.TEXTURE_MIN_FILTER = origin_ctx.TEXTURE_MIN_FILTER;
    // batchGL.NEAREST = origin_ctx.NEAREST;
    // batchGL.ARRAY_BUFFER = origin_ctx.ARRAY_BUFFER;
    // batchGL.STATIC_DRAW = origin_ctx.STATIC_DRAW;
    // batchGL.ELEMENT_ARRAY_BUFFER = origin_ctx.ELEMENT_ARRAY_BUFFER;
    // batchGL.COLOR_BUFFER_BIT = origin_ctx.COLOR_BUFFER_BIT;
    // batchGL.DEPTH_BUFFER_BIT = origin_ctx.DEPTH_BUFFER_BIT;
    // batchGL.FLOAT = origin_ctx.FLOAT;
    // batchGL.TEXTURE0 = origin_ctx.TEXTURE0;
    // batchGL.UNSIGNED_SHORT = origin_ctx.UNSIGNED_SHORT;
    // batchGL.TRIANGLES = origin_ctx.TRIANGLES;
    // batchGL.DEPTH_TEST = origin_ctx.DEPTH_TEST;
    // batchGL.LINK_STATUS = origin_ctx.LINK_STATUS;
    // batchGL.LOW_INT = origin_ctx.LOW_INT;
    // batchGL.MEDIUM_INT = origin_ctx.MEDIUM_INT;
    // batchGL.HIGH_INT = origin_ctx.HIGH_INT;
    // batchGL.LOW_FLOAT = origin_ctx.LOW_FLOAT;
    // batchGL.MEDIUM_FLOAT = origin_ctx.MEDIUM_FLOAT;
    // batchGL.HIGH_FLOAT = origin_ctx.HIGH_FLOAT;
    
    // ClearBufferMask
    batchGL.DEPTH_BUFFER_BIT = origin_ctx.DEPTH_BUFFER_BIT;
    batchGL.STENCIL_BUFFER_BIT = origin_ctx.STENCIL_BUFFER_BIT;
    batchGL.COLOR_BUFFER_BIT = origin_ctx.COLOR_BUFFER_BIT;
    
    // Boolean
    batchGL.FALSE = origin_ctx.FALSE;
    batchGL.TRUE = origin_ctx.TRUE;
    
    // BeginMode
    batchGL.POINTS = origin_ctx.POINTS;
    batchGL.LINES = origin_ctx.LINES;
    batchGL.LINE_LOOP = origin_ctx.LINE_LOOP;
    batchGL.LINE_STRIP = origin_ctx.LINE_STRIP;
    batchGL.TRIANGLES = 4;
    batchGL.TRIANGLE_STRIP = origin_ctx.TRIANGLE_STRIP;
    batchGL.TRIANGLE_FAN = origin_ctx.TRIANGLE_FAN;
    
    // BlendingFactorDest
    batchGL.ZERO = origin_ctx.ZERO;
    batchGL.ONE = origin_ctx.ONE;
    batchGL.SRC_COLOR = origin_ctx.SRC_COLOR;
    batchGL.ONE_MINUS_SRC_COLOR = origin_ctx.ONE_MINUS_SRC_COLOR;
    batchGL.SRC_ALPHA = origin_ctx.SRC_ALPHA;
    batchGL.ONE_MINUS_SRC_ALPHA = origin_ctx.ONE_MINUS_SRC_ALPHA;
    batchGL.DST_ALPHA = origin_ctx.DST_ALPHA;
    batchGL.ONE_MINUS_DST_ALPHA = origin_ctx.ONE_MINUS_DST_ALPHA;
    
    // BlendingFactorSrc
    // GL_ZERO
    // GL_ONE
    batchGL.DST_COLOR = origin_ctx.DST_COLOR;
    batchGL.ONE_MINUS_DST_COLOR = origin_ctx.ONE_MINUS_DST_COLOR;
    batchGL.SRC_ALPHA_SATURATE = origin_ctx.SRC_ALPHA_SATURATE;
    // GL_SRC_ALPHA
    
    // GL_ONE_MINUS_SRC_ALPHA
    // GL_DST_ALPHA
    // GL_ONE_MINUS_DST_ALPHA
    
    // BlendEquationSeparate
    batchGL.FUNC_ADD = origin_ctx.FUNC_ADD;
    batchGL.BLEND_EQUATION = origin_ctx.BLEND_EQUATION;
    batchGL.BLEND_EQUATION_RGB = origin_ctx.BLEND_EQUATION_RGB;
    batchGL.BLEND_EQUATION_ALPHA = origin_ctx.BLEND_EQUATION_ALPHA;
    
    // BlendSubtract
    batchGL.FUNC_SUBTRACT = origin_ctx.FUNC_SUBTRACT;
    batchGL.FUNC_REVERSE_SUBTRACT = origin_ctx.FUNC_REVERSE_SUBTRACT;
    
    // Separate Blend Functions
    batchGL.BLEND_DST_RGB = origin_ctx.BLEND_DST_RGB;
    batchGL.BLEND_SRC_RGB = origin_ctx.BLEND_SRC_RGB;
    batchGL.BLEND_DST_ALPHA = origin_ctx.BLEND_DST_ALPHA;
    batchGL.BLEND_SRC_ALPHA = origin_ctx.BLEND_SRC_ALPHA;
    batchGL.CONSTANT_COLOR = origin_ctx.CONSTANT_COLOR;
    batchGL.ONE_MINUS_CONSTANT_COLOR = origin_ctx.ONE_MINUS_CONSTANT_COLOR;
    batchGL.CONSTANT_ALPHA = origin_ctx.CONSTANT_ALPHA;
    batchGL.ONE_MINUS_CONSTANT_ALPHA = origin_ctx.ONE_MINUS_CONSTANT_ALPHA;
    batchGL.BLEND_COLOR = origin_ctx.BLEND_COLOR;
    
    // Buffer Objects
    batchGL.ARRAY_BUFFER = 34962;
    batchGL.ELEMENT_ARRAY_BUFFER = 34963;
    batchGL.ARRAY_BUFFER_BINDING = origin_ctx.ARRAY_BUFFER_BINDING;
    batchGL.ELEMENT_ARRAY_BUFFER_BINDING = origin_ctx.ELEMENT_ARRAY_BUFFER_BINDING;
    
    batchGL.STREAM_DRAW = origin_ctx.STREAM_DRAW;
    batchGL.STATIC_DRAW = origin_ctx.STATIC_DRAW;
    batchGL.DYNAMIC_DRAW = origin_ctx.DYNAMIC_DRAW;
    
    batchGL.BUFFER_SIZE = origin_ctx.BUFFER_SIZE;
    batchGL.BUFFER_USAGE = origin_ctx.BUFFER_USAGE;
    
    batchGL.CURRENT_VERTEX_ATTRIB = origin_ctx.CURRENT_VERTEX_ATTRIB;
    
    // CullFaceMode
    batchGL.FRONT = origin_ctx.FRONT;
    batchGL.BACK = origin_ctx.BACK;
    batchGL.FRONT_AND_BACK = origin_ctx.FRONT_AND_BACK;
    
    // EnableCap
    batchGL.TEXTURE_2D = 3553;
    batchGL.CULL_FACE = origin_ctx.CULL_FACE;
    batchGL.BLEND = origin_ctx.BLEND;
    batchGL.DITHER = origin_ctx.DITHER;
    batchGL.STENCIL_TEST = origin_ctx.STENCIL_TEST;
    batchGL.DEPTH_TEST = origin_ctx.DEPTH_TEST;
    batchGL.SCISSOR_TEST = origin_ctx.SCISSOR_TEST;
    batchGL.POLYGON_OFFSET_FILL = origin_ctx.POLYGON_OFFSET_FILL;
    batchGL.SAMPLE_ALPHA_TO_COVERAGE = origin_ctx.SAMPLE_ALPHA_TO_COVERAGE;
    batchGL.SAMPLE_COVERAGE = origin_ctx.SAMPLE_COVERAGE;
    
    // ErrorCode
    batchGL.NO_ERROR = origin_ctx.NO_ERROR;
    batchGL.INVALID_ENUM = origin_ctx.INVALID_ENUM;
    batchGL.INVALID_VALUE = origin_ctx.INVALID_VALUE;
    batchGL.INVALID_OPERATION = origin_ctx.INVALID_OPERATION;
    batchGL.OUT_OF_MEMORY = origin_ctx.OUT_OF_MEMORY;
    
    // FrontFaceDirection
    batchGL.CW = origin_ctx.CW;
    batchGL.CCW = origin_ctx.CCW;
    
    // GetPName
    batchGL.LINE_WIDTH = origin_ctx.LINE_WIDTH;
    batchGL.ALIASED_POINT_SIZE_RANGE = origin_ctx.ALIASED_POINT_SIZE_RANGE;
    batchGL.ALIASED_LINE_WIDTH_RANGE = origin_ctx.ALIASED_LINE_WIDTH_RANGE;
    batchGL.CULL_FACE_MODE = origin_ctx.CULL_FACE_MODE;
    batchGL.FRONT_FACE = origin_ctx.FRONT_FACE;
    batchGL.DEPTH_RANGE = origin_ctx.DEPTH_RANGE;
    batchGL.DEPTH_WRITEMASK = origin_ctx.DEPTH_WRITEMASK;
    batchGL.DEPTH_CLEAR_VALUE = origin_ctx.DEPTH_CLEAR_VALUE;
    batchGL.DEPTH_FUNC = origin_ctx.DEPTH_FUNC;
    batchGL.STENCIL_CLEAR_VALUE = origin_ctx.STENCIL_CLEAR_VALUE;
    batchGL.STENCIL_FUNC = origin_ctx.STENCIL_FUNC;
    batchGL.STENCIL_FAIL = origin_ctx.STENCIL_FAIL;
    batchGL.STENCIL_PASS_DEPTH_FAIL = origin_ctx.STENCIL_PASS_DEPTH_FAIL;
    batchGL.STENCIL_PASS_DEPTH_PASS = origin_ctx.STENCIL_PASS_DEPTH_PASS;
    batchGL.STENCIL_REF = origin_ctx.STENCIL_REF;
    batchGL.STENCIL_VALUE_MASK = origin_ctx.STENCIL_VALUE_MASK;
    batchGL.STENCIL_WRITEMASK = origin_ctx.STENCIL_WRITEMASK;
    batchGL.STENCIL_BACK_FUNC = origin_ctx.STENCIL_BACK_FUNC;
    batchGL.STENCIL_BACK_FAIL = origin_ctx.STENCIL_BACK_FAIL;
    batchGL.STENCIL_BACK_PASS_DEPTH_FAIL = origin_ctx.STENCIL_BACK_PASS_DEPTH_FAIL;
    batchGL.STENCIL_BACK_PASS_DEPTH_PASS = origin_ctx.STENCIL_BACK_PASS_DEPTH_PASS;
    batchGL.STENCIL_BACK_REF = origin_ctx.STENCIL_BACK_REF;
    batchGL.STENCIL_BACK_VALUE_MASK = origin_ctx.STENCIL_BACK_VALUE_MASK;
    batchGL.STENCIL_BACK_WRITEMASK = origin_ctx.STENCIL_BACK_WRITEMASK;
    batchGL.VIEWPORT = origin_ctx.VIEWPORT;
    batchGL.SCISSOR_BOX = origin_ctx.SCISSOR_BOX;
    // GL_SCISSOR_TEST
    batchGL.COLOR_CLEAR_VALUE = origin_ctx.COLOR_CLEAR_VALUE;
    batchGL.COLOR_WRITEMASK = origin_ctx.COLOR_WRITEMASK;
    batchGL.UNPACK_ALIGNMENT = origin_ctx.UNPACK_ALIGNMENT;
    batchGL.PACK_ALIGNMENT = origin_ctx.PACK_ALIGNMENT;
    batchGL.MAX_TEXTURE_SIZE = origin_ctx.MAX_TEXTURE_SIZE;
    batchGL.MAX_VIEWPORT_DIMS = origin_ctx.MAX_VIEWPORT_DIMS;
    batchGL.SUBPIXEL_BITS = origin_ctx.SUBPIXEL_BITS;
    batchGL.RED_BITS = origin_ctx.RED_BITS;
    batchGL.GREEN_BITS = origin_ctx.GREEN_BITS;
    batchGL.BLUE_BITS = origin_ctx.BLUE_BITS;
    batchGL.ALPHA_BITS = origin_ctx.ALPHA_BITS;
    batchGL.DEPTH_BITS = origin_ctx.DEPTH_BITS;
    batchGL.STENCIL_BITS = origin_ctx.STENCIL_BITS;
    batchGL.POLYGON_OFFSET_UNITS = origin_ctx.POLYGON_OFFSET_UNITS;
    // GL_POLYGON_OFFSET_FILL
    batchGL.POLYGON_OFFSET_FACTOR = origin_ctx.POLYGON_OFFSET_FACTOR;
    batchGL.TEXTURE_BINDING_2D = origin_ctx.TEXTURE_BINDING_2D;
    batchGL.SAMPLE_BUFFERS = origin_ctx.SAMPLE_BUFFERS;
    batchGL.SAMPLES = origin_ctx.SAMPLES;
    batchGL.SAMPLE_COVERAGE_VALUE = origin_ctx.SAMPLE_COVERAGE_VALUE;
    batchGL.SAMPLE_COVERAGE_INVERT = origin_ctx.SAMPLE_COVERAGE_INVERT;
    
    // GetTextureParameter
    // GL_TEXTURE_MAG_FILTER
    // GL_TEXTURE_MIN_FILTER
    // GL_TEXTURE_WRAP_S
    // GL_TEXTURE_WRAP_T
    
    batchGL.NUM_COMPRESSED_TEXTURE_FORMATS = origin_ctx.NUM_COMPRESSED_TEXTURE_FORMATS;
    batchGL.COMPRESSED_TEXTURE_FORMATS = origin_ctx.COMPRESSED_TEXTURE_FORMATS;
    
    // HintMode
    batchGL.DONT_CARE = origin_ctx.DONT_CARE;
    batchGL.FASTEST = origin_ctx.FASTEST;
    batchGL.NICEST = origin_ctx.NICEST;
    
    // HintTarget
    batchGL.GENERATE_MIPMAP_HINT = origin_ctx.GENERATE_MIPMAP_HINT;
    
    // DataType
    batchGL.BYTE = origin_ctx.BYTE;
    batchGL.UNSIGNED_BYTE = origin_ctx.UNSIGNED_BYTE;
    batchGL.SHORT = origin_ctx.SHORT;
    batchGL.UNSIGNED_SHORT = 5123;
    batchGL.INT = origin_ctx.INT;
    batchGL.UNSIGNED_INT = origin_ctx.UNSIGNED_INT;
    batchGL.FLOAT = 5126;
    batchGL.FIXED = origin_ctx.FIXED;
    
    // PixelFormat
    batchGL.DEPTH_COMPONENT = origin_ctx.DEPTH_COMPONENT;
    batchGL.ALPHA = origin_ctx.ALPHA;
    batchGL.RGB = origin_ctx.RGB;
    batchGL.RGBA = origin_ctx.RGBA;
    batchGL.LUMINANCE = origin_ctx.LUMINANCE;
    batchGL.LUMINANCE_ALPHA = origin_ctx.LUMINANCE_ALPHA;
    
    // PixelType
    // GL_UNSIGNED_BYTE
    batchGL.UNSIGNED_SHORT_4_4_4_4 = origin_ctx.UNSIGNED_SHORT_4_4_4_4;
    batchGL.UNSIGNED_SHORT_5_5_5_1 = origin_ctx.UNSIGNED_SHORT_5_5_5_1;
    batchGL.UNSIGNED_SHORT_5_6_5 = origin_ctx.UNSIGNED_SHORT_5_6_5;
    
    // Shaders
    batchGL.FRAGMENT_SHADER = origin_ctx.FRAGMENT_SHADER;
    batchGL.VERTEX_SHADER = origin_ctx.VERTEX_SHADER;
    batchGL.MAX_VERTEX_ATTRIBS = origin_ctx.MAX_VERTEX_ATTRIBS;
    batchGL.MAX_VERTEX_UNIFORM_VECTORS = origin_ctx.MAX_VERTEX_UNIFORM_VECTORS;
    batchGL.MAX_VARYING_VECTORS = origin_ctx.MAX_VARYING_VECTORS;
    batchGL.MAX_COMBINED_TEXTURE_IMAGE_UNITS = origin_ctx.MAX_COMBINED_TEXTURE_IMAGE_UNITS;
    batchGL.MAX_VERTEX_TEXTURE_IMAGE_UNITS = origin_ctx.MAX_VERTEX_TEXTURE_IMAGE_UNITS;
    batchGL.MAX_TEXTURE_IMAGE_UNITS = origin_ctx.MAX_TEXTURE_IMAGE_UNITS;
    batchGL.MAX_FRAGMENT_UNIFORM_VECTORS = origin_ctx.MAX_FRAGMENT_UNIFORM_VECTORS;
    batchGL.SHADER_TYPE = origin_ctx.SHADER_TYPE;
    batchGL.DELETE_STATUS = origin_ctx.DELETE_STATUS;
    batchGL.LINK_STATUS = origin_ctx.LINK_STATUS;
    batchGL.VALIDATE_STATUS = origin_ctx.VALIDATE_STATUS;
    batchGL.ATTACHED_SHADERS = origin_ctx.ATTACHED_SHADERS;
    batchGL.ACTIVE_UNIFORMS = origin_ctx.ACTIVE_UNIFORMS;
    batchGL.ACTIVE_UNIFORM_MAX_LENGTH = origin_ctx.ACTIVE_UNIFORM_MAX_LENGTH;
    batchGL.ACTIVE_ATTRIBUTES = origin_ctx.ACTIVE_ATTRIBUTES;
    batchGL.ACTIVE_ATTRIBUTE_MAX_LENGTH = origin_ctx.ACTIVE_ATTRIBUTE_MAX_LENGTH;
    batchGL.SHADING_LANGUAGE_VERSION = origin_ctx.SHADING_LANGUAGE_VERSION;
    batchGL.CURRENT_PROGRAM = origin_ctx.CURRENT_PROGRAM;
    
    // StencilFunction
    batchGL.NEVER = origin_ctx.NEVER;
    batchGL.LESS = origin_ctx.LESS;
    batchGL.EQUAL = origin_ctx.EQUAL;
    batchGL.LEQUAL = origin_ctx.LEQUAL;
    batchGL.GREATER = origin_ctx.GREATER;
    batchGL.NOTEQUAL = origin_ctx.NOTEQUAL;
    batchGL.GEQUAL = origin_ctx.GEQUAL;
    batchGL.ALWAYS = origin_ctx.ALWAYS;
    
    // StencilOp
    // GL_ZERO
    batchGL.KEEP = origin_ctx.KEEP;
    batchGL.REPLACE = origin_ctx.REPLACE;
    batchGL.INCR = origin_ctx.INCR;
    batchGL.DECR = origin_ctx.DECR;
    batchGL.INVERT = origin_ctx.INVERT;
    batchGL.INCR_WRAP = origin_ctx.INCR_WRAP;
    batchGL.DECR_WRAP = origin_ctx.DECR_WRAP;
    
    // StringName
    batchGL.VENDOR = origin_ctx.VENDOR;
    batchGL.RENDERER = origin_ctx.RENDERER;
    batchGL.VERSION = origin_ctx.VERSION;
    batchGL.EXTENSIONS = origin_ctx.EXTENSIONS;
    
    // TextureMagFilter
    batchGL.NEAREST = origin_ctx.NEAREST;
    batchGL.LINEAR = origin_ctx.LINEAR;
    
    // TextureMinFilter
    // GL_NEAREST
    // GL_LINEAR
    batchGL.NEAREST_MIPMAP_NEAREST = origin_ctx.NEAREST_MIPMAP_NEAREST;
    batchGL.LINEAR_MIPMAP_NEAREST = origin_ctx.LINEAR_MIPMAP_NEAREST;
    batchGL.NEAREST_MIPMAP_LINEAR = origin_ctx.NEAREST_MIPMAP_LINEAR;
    batchGL.LINEAR_MIPMAP_LINEAR = origin_ctx.LINEAR_MIPMAP_LINEAR;
    
    // TextureParameterName
    batchGL.TEXTURE_MAG_FILTER = origin_ctx.TEXTURE_MAG_FILTER;
    batchGL.TEXTURE_MIN_FILTER = origin_ctx.TEXTURE_MIN_FILTER;
    batchGL.TEXTURE_WRAP_S = origin_ctx.TEXTURE_WRAP_S;
    batchGL.TEXTURE_WRAP_T = origin_ctx.TEXTURE_WRAP_T;
    
    // TextureTarget
    // GL_TEXTURE_2D
    batchGL.TEXTURE = origin_ctx.TEXTURE;
    
    batchGL.TEXTURE_CUBE_MAP = origin_ctx.TEXTURE_CUBE_MAP;
    batchGL.TEXTURE_BINDING_CUBE_MAP = origin_ctx.TEXTURE_BINDING_CUBE_MAP;
    batchGL.TEXTURE_CUBE_MAP_POSITIVE_X = origin_ctx.TEXTURE_CUBE_MAP_POSITIVE_X;
    batchGL.TEXTURE_CUBE_MAP_NEGATIVE_X = origin_ctx.TEXTURE_CUBE_MAP_NEGATIVE_X;
    batchGL.TEXTURE_CUBE_MAP_POSITIVE_Y = origin_ctx.TEXTURE_CUBE_MAP_POSITIVE_Y;
    batchGL.TEXTURE_CUBE_MAP_NEGATIVE_Y = origin_ctx.TEXTURE_CUBE_MAP_NEGATIVE_Y;
    batchGL.TEXTURE_CUBE_MAP_POSITIVE_Z = origin_ctx.TEXTURE_CUBE_MAP_POSITIVE_Z;
    batchGL.TEXTURE_CUBE_MAP_NEGATIVE_Z = origin_ctx.TEXTURE_CUBE_MAP_NEGATIVE_Z;
    batchGL.MAX_CUBE_MAP_TEXTURE_SIZE = origin_ctx.MAX_CUBE_MAP_TEXTURE_SIZE;
    
    // TextureUnit
    batchGL.TEXTURE0 = 33984;
    batchGL.TEXTURE1 = origin_ctx.TEXTURE1;
    batchGL.TEXTURE2 = origin_ctx.TEXTURE2;
    batchGL.TEXTURE3 = origin_ctx.TEXTURE3;
    batchGL.TEXTURE4 = origin_ctx.TEXTURE4;
    batchGL.TEXTURE5 = origin_ctx.TEXTURE5;
    batchGL.TEXTURE6 = origin_ctx.TEXTURE6;
    batchGL.TEXTURE7 = origin_ctx.TEXTURE7;
    batchGL.TEXTURE8 = origin_ctx.TEXTURE8;
    batchGL.TEXTURE9 = origin_ctx.TEXTURE9;
    batchGL.TEXTURE10 = origin_ctx.TEXTURE10;
    batchGL.TEXTURE11 = origin_ctx.TEXTURE11;
    batchGL.TEXTURE12 = origin_ctx.TEXTURE12;
    batchGL.TEXTURE13 = origin_ctx.TEXTURE13;
    batchGL.TEXTURE14 = origin_ctx.TEXTURE14;
    batchGL.TEXTURE15 = origin_ctx.TEXTURE15;
    batchGL.TEXTURE16 = origin_ctx.TEXTURE16;
    batchGL.TEXTURE17 = origin_ctx.TEXTURE17;
    batchGL.TEXTURE18 = origin_ctx.TEXTURE18;
    batchGL.TEXTURE19 = origin_ctx.TEXTURE19;
    batchGL.TEXTURE20 = origin_ctx.TEXTURE20;
    batchGL.TEXTURE21 = origin_ctx.TEXTURE21;
    batchGL.TEXTURE22 = origin_ctx.TEXTURE22;
    batchGL.TEXTURE23 = origin_ctx.TEXTURE23;
    batchGL.TEXTURE24 = origin_ctx.TEXTURE24;
    batchGL.TEXTURE25 = origin_ctx.TEXTURE25;
    batchGL.TEXTURE26 = origin_ctx.TEXTURE26;
    batchGL.TEXTURE27 = origin_ctx.TEXTURE27;
    batchGL.TEXTURE28 = origin_ctx.TEXTURE28;
    batchGL.TEXTURE29 = origin_ctx.TEXTURE29;
    batchGL.TEXTURE30 = origin_ctx.TEXTURE30;
    batchGL.TEXTURE31 = origin_ctx.TEXTURE31;
    batchGL.ACTIVE_TEXTURE = origin_ctx.ACTIVE_TEXTURE;
    
    // TextureWrapMode
    batchGL.REPEAT = origin_ctx.REPEAT;
    batchGL.CLAMP_TO_EDGE = origin_ctx.CLAMP_TO_EDGE;
    batchGL.MIRRORED_REPEAT = origin_ctx.MIRRORED_REPEAT;
    
    // Uniform Types
    batchGL.FLOAT_VEC2 = origin_ctx.FLOAT_VEC2;
    batchGL.FLOAT_VEC3 = origin_ctx.FLOAT_VEC3;
    batchGL.FLOAT_VEC4 = origin_ctx.FLOAT_VEC4;
    batchGL.INT_VEC2 = origin_ctx.INT_VEC2;
    batchGL.INT_VEC3 = origin_ctx.INT_VEC3;
    batchGL.INT_VEC4 = origin_ctx.INT_VEC4;
    batchGL.BOOL = origin_ctx.BOOL;
    batchGL.BOOL_VEC2 = origin_ctx.BOOL_VEC2;
    batchGL.BOOL_VEC3 = origin_ctx.BOOL_VEC3;
    batchGL.BOOL_VEC4 = origin_ctx.BOOL_VEC4;
    batchGL.FLOAT_MAT2 = origin_ctx.FLOAT_MAT2;
    batchGL.FLOAT_MAT3 = origin_ctx.FLOAT_MAT3;
    batchGL.FLOAT_MAT4 = origin_ctx.FLOAT_MAT4;
    batchGL.SAMPLER_2D = origin_ctx.SAMPLER_2D;
    batchGL.SAMPLER_CUBE = origin_ctx.SAMPLER_CUBE;
    
    // Vertex Arrays
    batchGL.VERTEX_ATTRIB_ARRAY_ENABLED = origin_ctx.VERTEX_ATTRIB_ARRAY_ENABLED;
    batchGL.VERTEX_ATTRIB_ARRAY_SIZE = origin_ctx.VERTEX_ATTRIB_ARRAY_SIZE;
    batchGL.VERTEX_ATTRIB_ARRAY_STRIDE = origin_ctx.VERTEX_ATTRIB_ARRAY_STRIDE;
    batchGL.VERTEX_ATTRIB_ARRAY_TYPE = origin_ctx.VERTEX_ATTRIB_ARRAY_TYPE;
    batchGL.VERTEX_ATTRIB_ARRAY_NORMALIZED = origin_ctx.VERTEX_ATTRIB_ARRAY_NORMALIZED;
    batchGL.VERTEX_ATTRIB_ARRAY_POINTER = origin_ctx.VERTEX_ATTRIB_ARRAY_POINTER;
    batchGL.VERTEX_ATTRIB_ARRAY_BUFFER_BINDING = origin_ctx.VERTEX_ATTRIB_ARRAY_BUFFER_BINDING;
    
    // Read Format
    batchGL.IMPLEMENTATION_COLOR_READ_TYPE = origin_ctx.IMPLEMENTATION_COLOR_READ_TYPE;
    batchGL.IMPLEMENTATION_COLOR_READ_FORMAT = origin_ctx.IMPLEMENTATION_COLOR_READ_FORMAT;
    
    // Shader Source
    batchGL.COMPILE_STATUS = origin_ctx.COMPILE_STATUS;
    batchGL.INFO_LOG_LENGTH = origin_ctx.INFO_LOG_LENGTH;
    batchGL.SHADER_SOURCE_LENGTH = origin_ctx.SHADER_SOURCE_LENGTH;
    batchGL.SHADER_COMPILER = origin_ctx.SHADER_COMPILER;
    
    // Shader Binary
    batchGL.SHADER_BINARY_FORMATS = origin_ctx.SHADER_BINARY_FORMATS;
    batchGL.NUM_SHADER_BINARY_FORMATS = origin_ctx.NUM_SHADER_BINARY_FORMATS;
    
    // Shader Precision-Specified Types
    batchGL.LOW_FLOAT = origin_ctx.LOW_FLOAT;
    batchGL.MEDIUM_FLOAT = origin_ctx.MEDIUM_FLOAT;
    batchGL.HIGH_FLOAT = origin_ctx.HIGH_FLOAT;
    batchGL.LOW_INT = origin_ctx.LOW_INT;
    batchGL.MEDIUM_INT = origin_ctx.MEDIUM_INT;
    batchGL.HIGH_INT = origin_ctx.HIGH_INT;
    
    // Framebuffer Object.
    batchGL.FRAMEBUFFER = origin_ctx.FRAMEBUFFER;
    batchGL.RENDERBUFFER = origin_ctx.RENDERBUFFER;
    
    batchGL.RGBA4 = origin_ctx.RGBA4;
    batchGL.RGB5_A1 = origin_ctx.RGB5_A1;
    batchGL.RGB565 = origin_ctx.RGB565;
    batchGL.DEPTH_COMPONENT16 = origin_ctx.DEPTH_COMPONENT16;
    
    // Not sure if it makes sense to alias STENCIL_INDEX or if it should be
    // removed completely.
    
    batchGL.STENCIL_INDEX = origin_ctx.STENCIL_INDEX;
    batchGL.STENCIL_INDEX8 = origin_ctx.STENCIL_INDEX8;
    batchGL.DEPTH_STENCIL = origin_ctx.DEPTH_STENCIL;
    
    batchGL.RENDERBUFFER_WIDTH = origin_ctx.RENDERBUFFER_WIDTH;
    batchGL.RENDERBUFFER_HEIGHT = origin_ctx.RENDERBUFFER_HEIGHT;
    batchGL.RENDERBUFFER_INTERNAL_FORMAT = origin_ctx.RENDERBUFFER_INTERNAL_FORMAT;
    batchGL.RENDERBUFFER_RED_SIZE = origin_ctx.RENDERBUFFER_RED_SIZE;
    batchGL.RENDERBUFFER_GREEN_SIZE = origin_ctx.RENDERBUFFER_GREEN_SIZE;
    batchGL.RENDERBUFFER_BLUE_SIZE = origin_ctx.RENDERBUFFER_BLUE_SIZE;
    batchGL.RENDERBUFFER_ALPHA_SIZE = origin_ctx.RENDERBUFFER_ALPHA_SIZE;
    batchGL.RENDERBUFFER_DEPTH_SIZE = origin_ctx.RENDERBUFFER_DEPTH_SIZE;
    batchGL.RENDERBUFFER_STENCIL_SIZE = origin_ctx.RENDERBUFFER_STENCIL_SIZE;
    
    batchGL.FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE = origin_ctx.FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE;
    batchGL.FRAMEBUFFER_ATTACHMENT_OBJECT_NAME = origin_ctx.FRAMEBUFFER_ATTACHMENT_OBJECT_NAME;
    batchGL.FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL = origin_ctx.FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL;
    batchGL.FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE = origin_ctx.FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE;
    
    batchGL.COLOR_ATTACHMENT0 = origin_ctx.COLOR_ATTACHMENT0;
    batchGL.DEPTH_ATTACHMENT = origin_ctx.DEPTH_ATTACHMENT;
    batchGL.STENCIL_ATTACHMENT = origin_ctx.STENCIL_ATTACHMENT;
    batchGL.DEPTH_STENCIL_ATTACHMENT = origin_ctx.DEPTH_STENCIL_ATTACHMENT;
    
    
    batchGL.NONE = origin_ctx.NONE;
    
    batchGL.FRAMEBUFFER_COMPLETE = origin_ctx.FRAMEBUFFER_COMPLETE;
    batchGL.FRAMEBUFFER_INCOMPLETE_ATTACHMENT = origin_ctx.FRAMEBUFFER_INCOMPLETE_ATTACHMENT;
    batchGL.FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT = origin_ctx.FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT;
    batchGL.FRAMEBUFFER_INCOMPLETE_DIMENSIONS = origin_ctx.FRAMEBUFFER_INCOMPLETE_DIMENSIONS;
    batchGL.FRAMEBUFFER_UNSUPPORTED = origin_ctx.FRAMEBUFFER_UNSUPPORTED;
    
    batchGL.FRAMEBUFFER_BINDING = origin_ctx.FRAMEBUFFER_BINDING;
    batchGL.RENDERBUFFER_BINDING = origin_ctx.RENDERBUFFER_BINDING;
    batchGL.MAX_RENDERBUFFER_SIZE = origin_ctx.MAX_RENDERBUFFER_SIZE;
    
    batchGL.INVALID_FRAMEBUFFER_OPERATION = origin_ctx.INVALID_FRAMEBUFFER_OPERATION;
    
    // WebGL-specific enums
    batchGL.UNPACK_FLIP_Y_WEBGL = origin_ctx.UNPACK_FLIP_Y_WEBGL;
    batchGL.UNPACK_PREMULTIPLY_ALPHA_WEBGL = origin_ctx.UNPACK_PREMULTIPLY_ALPHA_WEBGL;
    batchGL.CONTEXT_LOST_WEBGL = origin_ctx.CONTEXT_LOST_WEBGL;
    batchGL.UNPACK_COLORSPACE_CONVERSION_WEBGL = origin_ctx.UNPACK_COLORSPACE_CONVERSION_WEBGL;
    batchGL.BROWSER_DEFAULT_WEBGL = origin_ctx.BROWSER_DEFAULT_WEBGL;
    var ret = Object.create(batchGL);
    ret.ctxid = origin_ctx.__id();
    ret._map = new Map();
    ret.origin_ctx = origin_ctx;
    
    Object.defineProperty(batchGL, "drawingBufferWidth", {
        get: function() {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring + ';141';
            return this.batchRender(true);
        },
        configurable: true,
        enumerable: true
    });
    Object.defineProperty(batchGL, "drawingBufferHeight", {
        get: function() {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring + ';142';
            return this.batchRender(true);
        },
        configurable: true,
        enumerable: true
    });
    
    return ret;
}

function getUtf8Length(s) {
    s = s.toString();
    var len = 0;
    for (var i = 0; i < s.length; i++) {
        var code = s.charCodeAt(i);
        if (code <= 0x7f) {
            len += 1;
        } else if (code <= 0x7ff) {
            len += 2;
        } else if (code >= 0xd800 && code <= 0xdfff) {
            len += 4; i++;
        } else {
            len += 3;
        }
    }
    return len;
}

var __getCanvasContext__ = function(origin_ctx){
    return origin_ctx;

    var batchRender = function (sync) {
        var r = commandRender(commonstring, sync);
        commonstring = "";
        return r;
    }
    var batchGL = {
        ctxid : origin_ctx.__id(),
        createPattern:function(pattern, repeat){
            checkContextChange(this.ctxid, 0);
            var argc = arguments.length;
            var rep = 'repeat';
            if (argc == 2) {    rep=repeat; }
            commonstring = commonstring + ';1,2,' + pattern.uid + ',' + rep.length + ',' + rep;
            var ret = batchRender(true);
            ret.uin = ret.instance;
            return ret;
        },
        createLinearGradient:function(x1, y1, x2, y2){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';2,4,' + x1 + ',' + y1 + ',' + x2 + ',' + y2;
            var ret = batchRender(true);
            ret.uin = ret.instance;
            return ret;
        },
        getImageData:function(sx, sy, sw, sh){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';3,4,' + sx + ',' + sy + ',' + sw + ',' + sh;
            return batchRender(true);
        },
        measureText:function(str){
            checkContextChange(this.ctxid, 0);
            var len = getUtf8Length(str);
            commonstring = commonstring + ';4,1,' + len + ',' + str;
            return batchRender(true);
        },
        setTransform:function(m11, m12, m21, m22, dx, dy){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';5,6,' + m11 + ',' + m12+ ',' + m21+ ',' + m22+ ',' + dx+ ',' + dy;
            batchRender(true);
        },
        clearRect:function(dx, dy, w, h){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';6,4,' + dx + ',' + dy+ ',' + w+ ',' + h;
            batchRender(true);
        },
        scale:function(x, y){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';7,2,' + x + ',' + y;
            batchRender(true);
        },
        fillText:function(str, x, y){
            checkContextChange(this.ctxid, 0);
            var len = getUtf8Length(str);
            commonstring = commonstring + ';8,3,' + x + ',' + y + ',' + len + ',' + str;
            batchRender(true);
        },
        fillRect:function(x, y, w, h){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';9,4,' + x + ',' + y + ',' + w + ',' + h;
            batchRender(true);
        },
        //            void ctx.drawImage(image, dx, dy);
        //            void ctx.drawImage(image, dx, dy, dWidth, dHeight);
        //            void ctx.drawImage(image, sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight);
        drawImage:function(image, sx, sy, sw, sh, dx, dy, dw, dh){
            checkContextChange(this.ctxid, 0);
            var argc = arguments.length;
            if(argc == 3){
                commonstring = commonstring + ';10,3,' + image.uid + ',' + sx + ',' + sy;
            }
            else if(argc == 5){
                commonstring = commonstring + ';10,5,' + image.uid + ',' + sx + ',' + sy + ',' + sw + ',' + sh;
            }
            else if(argc == 9){
                commonstring = commonstring + ';10,9,' + image.uid + ',' + sx + ',' + sy + ',' + sw + ',' + sh + ',' + dx + ',' + dy + ',' + dw + ',' + dh;
            }
            batchRender(true);
        },
        beginPath:function(){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';20';
        },
        closePath:function(){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';21';
        },
        moveTo:function(x, y){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';22,2,' + x + ',' +y;
        },
        lineTo:function(x, y){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';23,2,' + x + ',' +y;
        },
        rect:function(x, y, w, h){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';24,4,' + x + ',' +y + ',' +w + ',' +h;
        },
        quadraticCurveTo:function(x, y, w, h){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';25,4,' + x + ',' +y + ',' +w + ',' +h;
        },
        bezierCurveTo:function(x, y, a, b, w, h){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';26,6,' + x + ',' + y + ',' + a + ',' + b + ',' +w + ',' +h;
        },
        arcTo:function(x1, y1, x2, y2, r){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';27,5,' + x1 + ',' + y1 + ',' + x2 + ',' + y2 + ',' + r;
        },
        arc:function(x, y, r, start, end, clock){
            checkContextChange(this.ctxid, 0);
            var argc = arguments.length;
            if(argc==5){
                commonstring = commonstring + ';28,6,' + x + ',' + y + ',' + r + ',' + start + ',' + end + ',' + 0;
            }
            else{
                commonstring = commonstring + ';28,6,' + x + ',' + y + ',' + r + ',' + start + ',' + end + ',' + 1;
            }
        },
        stroke:function(){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';29';
        },
        save:function(){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';30';
        },
        restore:function(){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';31';
        },
        translate:function(x, y){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';32,2,' + x + ',' + y;
        },
        strokeText:function(str, x, y){
            checkContextChange(this.ctxid, 0);
            var len = getUtf8Length(str);
            commonstring = commonstring + ';33,3,' + x + ',' + y + ',' + len + ',' + str;
        },
        clip:function(mode){
            checkContextChange(this.ctxid, 0);
            var argc = arguments.length;
            if(argc==0){
                commonstring = commonstring + ';34,0';
            }
            else{
                commonstring = commonstring + ';34,1,' + mode.length + ',' + mode;
            }
        },
        fill:function(mode){
            checkContextChange(this.ctxid, 0);
            var argc = arguments.length;
            if(argc==0){
                commonstring = commonstring + ';35,0';
            }
            else{
                commonstring = commonstring + ';35,1,' + mode.length + ',' + mode;
            }
        },
        rotate:function(angle){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';36,1,' + angle;
        },
        transform:function(m11, m12, m21, m22, dx, dy){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';37,6,' + m11 + ',' + m12 + ',' + m21 + ',' + m22 + ',' + dx + ',' + dy;
        },
        strokeRect:function(dx, dy, w, h){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';38,4,' + dx + ',' + dy + ',' + w + ',' + h;
        },
        resetClip:function(){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';39';
        },
        createRadialGradient:function(x0,y0, r0, x1, y1, r1){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';40,6,' + x0 + ',' + y0 + ',' + r0 + ',' + x1 + ',' + y1 + ',' + r1;
            var ret = batchRender(true);
            ret.uin = ret.instance;
            return ret;
        },
        createImageData:function(w, h){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';41,2,' + w + ',' + h;
            var ret = batchRender(true);
            ret.uin = ret.instance;
            return ret;
        },
        putImageData:function(data, x, y){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';42,3,' + data.uin + ',' + x + ',' + y;
        },
        wxSetContextAttributes: function (dic) {
            checkContextChange(this.ctxid, 1);
            commonstring = commonstring  + ';43,2,' + dic.antialias + ',' + dic.antialiasSamples;
        },
    };
    var context = Object.create(batchGL);
    context.ctxid = origin_ctx.__id();
    
    Object.defineProperty(context, "fillStyle", {
      set: function(newValue) {
          if (typeof newValue === 'string'){
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';13,1,' + newValue.length + ',' + newValue;
          }
          else{
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';12,1,' + newValue.uin;
          }
      },
      get: function() {
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';11';
            return batchRender(true);
      }
  });
    Object.defineProperty(context, "font", {
      set: function(newValue) {
            checkContextChange(this.ctxid, 0);
            var len = getUtf8Length(newValue);
            commonstring = commonstring + ';15,1,' + len + ',' + newValue;
      },
      get: function() {
            checkContextChange(this.ctxid, 0);
            commonstring = commonstring + ';14';
            return batchRender(true);
      }
  });
    Object.defineProperty(context, "textBaseline", {
      get: function() {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';16';
          return batchRender(true);
      },
      set: function(newValue) {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';17,1,' + newValue.length + ',' + newValue;
      }
  });
    Object.defineProperty(context, "textAlign", {
      get: function() {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';18';
          return batchRender(true);
      },
      set: function(newValue) {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';19,1,' + newValue.length + ',' + newValue;
      }
  });
    Object.defineProperty(context, "globalCompositeOperation", {
      get: function() {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';44';
          return batchRender(true);
      },
      set: function(newValue) {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';45,1,' + newValue.length + ',' + newValue;
      }
  });
    Object.defineProperty(context, "lineCap", {
      get: function() {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';46';
          return batchRender(true);
      },
      set: function(newValue) {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';47,1,' + newValue.length + ',' + newValue;
      }
  });
    Object.defineProperty(context, "lineJoin", {
      get: function() {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';48';
          return batchRender(true);
      },
      set: function(newValue) {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';49,1,' + newValue.length + ',' + newValue;
      }
  });
    Object.defineProperty(context, "strokeStyle", {
      get: function() {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';50';
          return batchRender(true);
      },
      set: function(newValue) {
        checkContextChange(this.ctxid, 0);
        if (typeof newValue === 'string'){
            commonstring = commonstring + ';51,1,' + newValue.length + ',' + newValue;
        }
        else{
            commonstring = commonstring + ';52,1,' + newValue.uin;
        }
      }
  });
    Object.defineProperty(context, "globalAlpha", {
      get: function() {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';53';
          return batchRender(true);
      },
      set: function(newValue) {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';54,1,' + newValue;
      }
  });
    Object.defineProperty(context, "lineWidth", {
      get: function() {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';55';
          return batchRender(true);
      },
      set: function(newValue) {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';56,1,' + newValue;
      }
  });
    Object.defineProperty(context, "miterLimit", {
      get: function() {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';57';
          return batchRender(true);
      },
      set: function(newValue) {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';58,1,' + newValue;
      }
  });
    Object.defineProperty(context, "imageSmoothingEnabled", {
      get: function() {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';59';
          return batchRender(true);
      },
      set: function(newValue) {
          checkContextChange(this.ctxid, 0);
          commonstring = commonstring + ';60,1,' + newValue ? 1: 0;
      }
  });
    return context;
}


