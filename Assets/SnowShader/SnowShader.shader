// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ShaderTest/SnowShader"{
   Properties{
       _MainTex("Texture", 2D) = "white"{}
       _SnowDir("SnowDir", Vector) = (0, 1, 0)
       _SnowColor("SnowColor", Color) = (1, 1, 1, 1)
       _Snow ("Snow Level", Range(0,1)) = 0
       _SnowNum("SnowNum", Range(0, 1)) = 0
   }

   SubShader{
       Tags{ "RenderType" = "Opaque" }

       Pass{
           
           CGPROGRAM
           #include "Lighting.cginc"

           #pragma vertex vert
           #pragma fragment frag

           sampler2D _MainTex;
           float4 _MainTex_ST;
           float3 _SnowDir;
           float4 _SnowColor;
           float _Snow;
           float _SnowNum;

           struct v2f{
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD0;
                float2 uv : TEXCOORD1;
           };

           v2f vert(appdata_base v){
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
           }

           fixed4 frag(v2f i) : SV_Target {
                fixed3 tex = tex2D(_MainTex, i.uv);
                float3 worldNormal = normalize(i.normal);
                //fixed colNum = smoothstep(0, 1, dot(_SnowDir, worldNormal));
                // fixed3 color = tex;
                // float4 sn = mul(UNITY_MATRIX_IT_MV, _SnowDir);
                // if(dot(worldNormal, sn.xyz) > lerp(1,-1,_Snow))
                //     color = _SnowColor;
                // else
                //     color = color;
                // fixed3 finalColor = lerp(tex, _SnowColor, colorNum);
                float colorNum = smoothstep(_SnowNum , 1, dot(_SnowDir, worldNormal));
                 fixed3 colNum=lerp(tex, _SnowColor,colorNum);
                return fixed4(colNum, 1);
           }

           ENDCG
       }
   }

   Fallback "Diffuse"
}