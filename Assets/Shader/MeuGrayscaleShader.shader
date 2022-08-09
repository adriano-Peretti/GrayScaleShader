Shader "MeuShader/MeuGrayscaleShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
        _Greyscale ("Greyscale", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }

        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct MeshData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct VertexOutput
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            sampler2D _MainTex;
            fixed4 _Color;
            float4 _MainTex_ST;
            float _Greyscale;

            VertexOutput vert (MeshData meshData)
            {
                VertexOutput o;
                o.vertex = UnityObjectToClipPos(meshData.vertex);
                o.uv = TRANSFORM_TEX (meshData.uv, _MainTex);
                return o;
            }

            fixed4 frag (VertexOutput input) : SV_Target
            {
                // sample the texture
                fixed4 cor = tex2D(_MainTex, input.uv) * _Color;

                float intensity = cor.r * 0.299 + cor.g * 0.587 + cor.b * 0.114;
                fixed4 bandw = fixed4(intensity, intensity, intensity, cor.a);
                fixed4 lerped = lerp(cor, bandw, _Greyscale);


                return lerped;
            }
            ENDCG
        }
    }
}
