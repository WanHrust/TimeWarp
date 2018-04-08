using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rocket : MonoBehaviour {
    public Transform target;
    Rigidbody rb;
	// Use this for initialization
	void Start () {
        rb = GetComponent<Rigidbody>();
	}
	// Update is called once per frame
	void Update () {
        rb.AddForce(target.position - gameObject.transform.position);
    }

    void OnTriggerEnter(Collider collider) {
        if(collider.gameObject.CompareTag("InfluenceSphere")) {
            Debug.Log("Sphere Colliding");
        }
    }
}
