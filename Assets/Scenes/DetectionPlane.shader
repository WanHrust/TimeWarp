Shader "Custom/DetectionPlane"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Radius("Radius", Range(0.0, 7.5)) = 5
		_Highlight("Highlight", Color) = (1,1,1,1)
		_Thickness("Thickness", Range(0.0, 1.0)) = 0.0
		_Amplitude("Amlitude", Range(0.0,1.0)) = 0.0
		_Transparency("Transparency", Range(0.0, 1.0)) = 1.0
	}
	SubShader
	{
		Tags{ "Queue" = "Transparent" "RenderType" = "Transparent" }
		LOD 100

		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float3 localVertex : POSITION1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Radius;
			float _Thickness;
			float _Amplitude;
			float4 _Highlight;
			float _Transparency;

			v2f vert (appdata v)
			{
				v2f o;
				o.localVertex = v.vertex.xyz;
				float dist = distance(v.vertex.xyz, float3(0, 0, 0));
				if (dist >= (_Radius - _Thickness)   &&  dist <= _Radius + _Thickness) {
					v.vertex.z += _Amplitude;
				}
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = float4(0,0,0,0);
				// sample the texture
				float dist = distance(i.localVertex, float3(0, 0, 0));
				if (dist <= _Radius) {
					col = tex2D(_MainTex, i.uv);
					col *= col.a;
					col.a *= _Transparency;
					if (dist >= _Radius - _Thickness -0.2  && dist <= _Radius + _Thickness - 0.1 ) {
						col *= _Highlight;
					}
				}

				if (_Radius >= 5){
				if (abs(i.localVertex.x) >= 4.95 && abs(i.localVertex.z) <= _Radius - 2.5) {
					col = float4(1, 1, 1, 1);
				}
				if (abs(i.localVertex.z) >= 4.95 && abs(i.localVertex.x) <= _Radius - 2.5) {
					col = float4(1, 1, 1, 1);
				}
			}
				return col;
			}
			ENDCG
		}
	}
}
