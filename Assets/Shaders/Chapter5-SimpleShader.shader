// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unity Shader Book/Chapter 5/Simple Shader" {
    Properties {
        // 声明一个Color类型的属性, 名称为"Color Tint", 默认值为(1.0, 1.0, 1.0, 1.0), _Color是属性在着色器中的名字
        _Color ("Color Tint", Color) = (1.0,1.0,1.0,1.0)
    }
    SubShader {       
        Pass {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag

            // 在CG代码块中, 我们需要定义一个与属性名称和类型相同的变量, 用于在着色器中访问属性
            fixed4 _Color;
            
            // 使用一个结构体来定义顶点着色器的输入
            struct a2v {
                // POSITION语义告诉Unity, 用模型空间的顶点坐标填充vertex变量
                float4 vertex : POSITION;
                // NORMAL语义告诉Unity, 用模型空间的法线坐标填充normal变量
                float3 normal : NORMAL;
                // TEXCOORD0语义告诉Unity, 用模型的第一套纹理坐标填充texcoord变量
                float4 texcoord : TEXCOORD0;
            };

            // 使用一个结构体来定义顶点着色器的输出
            struct v2f {
                // SV_POSITION语义告诉Unity, 用裁剪空间的顶点坐标填充pos变量
                float4 pos : SV_POSITION;
                // COLOR0语义告诉Unity, 用颜色填充color变量
                float3 color : COLOR0;
            };

            v2f vert(a2v v) {
                // 使用v.vertex来访问模型空间的顶点坐标
				// return UnityObjectToClipPos (v.vertex);

                // 声明输出结构
                v2f o;
                o.pos = UnityObjectToClipPos (v.vertex);
                // v.normal是模型空间的法线坐标, 其分量范围在(-1.0, 1.0)之间
                // 下面的代码将其转换到(0.0, 1.0)之间
                // 储存到o.color中, 传递给片元着色器
                o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
                return o;
			}

            fixed4 frag(v2f i) : SV_Target {
                //return fixed4(1.0, 1.0, 1.0, 1.0);

                // 将插值后的i.color显示到屏幕上
                // return fixed4(i.color, 1.0);

                fixed3 c = i.color;
                // 使用_Color属性的值来调整颜色
                c *= _Color.rgb;
                return fixed4(c, 1.0);
            }

            ENDCG
        }
    }
}
