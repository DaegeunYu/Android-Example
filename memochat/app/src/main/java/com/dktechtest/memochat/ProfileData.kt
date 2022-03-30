package com.dktechtest.memochat

data class ProfileData(
    val results: List<Items>
)

data class Items(
    val gender: String,
    val name: Name,
    val picture: String
)

data class Name(
    val title: String,
    val last: String
)
