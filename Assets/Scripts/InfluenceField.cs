using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InfluenceField : MonoBehaviour {

    Material material;
	// Use this for initialization
	void Start () {
        material = GetComponent<MeshRenderer>().material;
	}
	
	// Update is called once per frame
	void Update () {
      
	}

    void OnTriggerEnter(Collider other) {
        material.SetVector("_ImpactPosition", other.transform.position);
        TimeControl tc = other.GetComponent<TimeControl>();
        if(tc) {
            tc.timeScale = 0.01f;
        }
    }

    private void OnTriggerExit(Collider other) {
        TimeControl tc = other.GetComponent<TimeControl>();
        if (tc) {
            tc.timeScale = 1.0f;
        }
    }

}
