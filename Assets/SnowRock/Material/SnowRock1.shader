﻿Shader "Custom/SnowShader" {
    Properties {
        _MainTex ("Base (RGB)", 2D) = "white" {}
 
        //新的凹凸纹理贴图
        _Bump ("Bump", 2D) = "bump" {}
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        LOD 200
 
        CGPROGRAM
        #pragma surface surf Lambert
 
        sampler2D _MainTex;
        //必须添加一个与Properties代码区中的同名的_Bump变量，作为Properties中_Bump的引用。        
        //具体缘由详见教程第一部分。
         sampler2D _Bump;
 
        struct Input {
            float2 uv_MainTex;
            //用来得到_Bump的uv坐标
            float2 uv_Bump;
        };
 
        void surf (Input IN, inout SurfaceOutput o) {
            half4 c = tex2D (_MainTex, IN.uv_MainTex);
 
            //从_Bump纹理中提取法向信息
            o.Normal = UnpackNormal(tex2D(_Bump, IN.uv_Bump));
 
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}