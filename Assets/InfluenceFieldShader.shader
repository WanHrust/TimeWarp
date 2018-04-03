Shader "Unlit/InfluenceFieldShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_AlbedoColor("Color", Color) = (1.0, 0.0, 0.0, 1.0)
		_ImpactColor("Impact Color", Color) = (0.0, 1.0, 0.0, 1.0)

		_Scale("Scale", float) = 1.0
		_Speed("Speed", float) = 1.0
		_Frequency("Frequency", float) = 1.0
	}
	SubShader
	{
		Tags { "Queue"="Transparent" "RenderType"="Transparent" }
		LOD 100
		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"


      uniform float3 _ImpactPosition;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
        float4 position : TEXCOORD1;
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _ImpactColor;
			float _AlbedoColor;
			float _Scale;
			float _Speed;
			float _Frequency;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.position = mul(unity_ObjectToWorld, v.vertex);
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
			}
			
			fixed4 frag(v2f i) : SV_Target
			{
				float dist = distance(i.position, _ImpactPosition);
				if (dist < 2) {
					float value = _Scale * sin(_Time.w * _Speed + 1/dist * _Frequency) / dist;
					return (_ImpactColor * value);
				}
				else 
					return _AlbedoColor;
			}
			ENDCG
		}
	}
}
