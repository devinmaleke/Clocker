//
//  AfterChooseLockerView.swift
//  LockLock
//
//  Created by Devin Maleke on 24/03/23.
//

import SwiftUI

struct AfterChooseLockerView: View {
    @EnvironmentObject var dbQuery: DBQuery
    @Binding var isOk: Bool
    var body: some View {
        NavigationView{
            if(!dbQuery.curLockers[0].isEmpty){
                VStack (alignment: .leading){
                    HStack(){
                        NavigationLink(destination: SelectLockerView().navigationBarHidden(true)){
                            Label("Add Locker", systemImage: "square.split.1x2")
                                .frame(width: 155, height: 40)
                                .foregroundColor(.white)
                                .background(Color(red: -0.002, green: 0.502, blue: 0.662))
                                .cornerRadius(10)
                                .padding()
                        }
                        Label("Clock-out", systemImage: "arrow.up.circle")
                            .frame(width: 155, height: 40)
                            .foregroundColor(.white)
                            .background(Color(red: -0.002, green: 0.502, blue: 0.662))
                            .cornerRadius(10)
                        
                        
                    }.onAppear(perform:{
                        dbQuery.getCurLocker()
                    })
                    
                    
                    List{VStack(alignment: .leading){
                        Text("Currently Used Locker").font(Font.headline.weight(.bold))
                            .foregroundColor(Color(red: -0.002, green: 0.502, blue: 0.662))
                            .padding(.bottom,10)
                        //                Divider()
                        //                        .background(Color(.black))
                        
                        //if(!dbQuery.curLockers[0].isEmpty){
                            ForEach(0..<dbQuery.curLockers[0].count){ locker in
                                if locker<dbQuery.curLockers[0].count {
                                    VStack{
                                        Divider()
                                            .background(Color(.gray))
                                        HStack{
                                            Label("LA\(dbQuery.curLockers[0][locker].id)", systemImage: "square.split.1x2")
                                                .foregroundColor(Color(red: -0.002, green: 0.502, blue: 0.662))
                                            
                                            Spacer()
                                            
                                            
                                            Button(action:{
                                                
                                            }){
                                                Image(systemName: "minus.circle")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 20))
                                                    .padding(10)
                                                    .background(Color.red)
                                                    .frame(width: 20, height: 20)
                                                    .clipShape(Circle())
                                            }.onTapGesture {
                                                print("=========================")
                                                print(locker)
                                                print(dbQuery.curLockers)
                                                dbQuery.toggleLockers(section: "LA", id: dbQuery.curLockers[0][locker].id, action: false)
                                                dbQuery.lockers[0][dbQuery.curLockers[0][locker].id - 1].isOccupied = false
                                                dbQuery.lockers[0][dbQuery.curLockers[0][locker].id - 1].userId = ""
                                                dbQuery.curLockers[0].remove(at: locker)
                                                
                                                print("\(dbQuery.curLockers[0].count)")
                                            }
                                        }
                                        .frame(height: 44)
                                        .padding()
                                    }
                                }
                            }
                       // }
                        //                    if(!dbQuery.curLockers[1].isEmpty){
                        //                        ForEach(0..<dbQuery.curLockers[1].count){ locker in
                        //                            if locker<dbQuery.curLockers[1].count {
                        //                                VStack{
                        //                                    Divider()
                        //                                        .background(Color(.gray))
                        //                                    HStack{
                        //                                        Label("LB\(dbQuery.curLockers[1][locker].id)", systemImage: "iconLocker")
                        //
                        //                                        Spacer()
                        //
                        //
                        //                                        Button(action:{
                        //
                        //                                        }){
                        //                                            Image(systemName: "minus.circle")
                        //                                                .foregroundColor(.white)
                        //                                                .font(.system(size: 20))
                        //                                                .padding(10)
                        //                                                .background(Color.red)
                        //                                                .frame(width: 20, height: 20)
                        //                                                .clipShape(Circle())
                        //                                        }.onTapGesture {
                        //                                            print("=========================")
                        //                                            print(locker)
                        //                                            print(dbQuery.curLockers)
                        //                                            dbQuery.toggleLockers(section: "LB", id: dbQuery.curLockers[1][locker].id, action: false)
                        //                                            dbQuery.lockers[1][dbQuery.curLockers[1][locker].id - 1].isOccupied = false
                        //                                            dbQuery.lockers[1][dbQuery.curLockers[1][locker].id - 1].userId = ""
                        //                                            dbQuery.curLockers[1].remove(at: locker)
                        //
                        //                                            print("\(dbQuery.curLockers[1].count)")
                        //                                        }
                        //                                    }
                        //                                }
                        //                            }
                        //                        }
                        //                    }
                        //                    if(!dbQuery.curLockers[2].isEmpty){
                        //                        ForEach(0..<dbQuery.curLockers[2].count){ locker in
                        //                            if locker<dbQuery.curLockers[2].count {
                        //                                VStack{
                        //                                    Divider()
                        //                                        .background(Color(.gray))
                        //                                    HStack{
                        //                                        Label("PA\(dbQuery.curLockers[2][locker].id)", systemImage: "iconLocker")
                        //
                        //                                        Spacer()
                        //
                        //
                        //                                        Button(action:{
                        //
                        //                                        }){
                        //                                            Image(systemName: "minus.circle")
                        //                                                .foregroundColor(.white)
                        //                                                .font(.system(size: 20))
                        //                                                .padding(10)
                        //                                                .background(Color.red)
                        //                                                .frame(width: 20, height: 20)
                        //                                                .clipShape(Circle())
                        //                                        }.onTapGesture {
                        //                                            print("=========================")
                        //                                            print(locker)
                        //                                            print(dbQuery.curLockers)
                        //                                            dbQuery.toggleLockers(section: "PA", id: dbQuery.curLockers[2][locker].id, action: false)
                        //                                            dbQuery.lockers[2][dbQuery.curLockers[2][locker].id - 1].isOccupied = false
                        //                                            dbQuery.lockers[2][dbQuery.curLockers[2][locker].id - 1].userId = ""
                        //                                            dbQuery.curLockers[2].remove(at: locker)
                        //
                        //                                            print("\(dbQuery.curLockers[2].count)")
                        //                                        }
                        //                                    }
                        //                                }
                        //                            }
                        //                        }
                        //                    }
                        //                    if(!dbQuery.curLockers[3].isEmpty){
                        //                        ForEach(0..<dbQuery.curLockers[3].count){ locker in
                        //                            if locker<dbQuery.curLockers[3].count {
                        //                                VStack{
                        //                                    Divider()
                        //                                        .background(Color(.gray))
                        //                                    HStack{
                        //                                        Label("PB\(dbQuery.curLockers[3][locker].id)", systemImage: "iconLocker")
                        //
                        //                                        Spacer()
                        //
                        //
                        //                                        Button(action:{
                        //
                        //                                        }){
                        //                                            Image(systemName: "minus.circle")
                        //                                                .foregroundColor(.white)
                        //                                                .font(.system(size: 20))
                        //                                                .padding(10)
                        //                                                .background(Color.red)
                        //                                                .frame(width: 20, height: 20)
                        //                                                .clipShape(Circle())
                        //                                        }.onTapGesture {
                        //                                            print("=========================")
                        //                                            print(locker)
                        //                                            print(dbQuery.curLockers)
                        //                                            dbQuery.toggleLockers(section: "PB", id: dbQuery.curLockers[3][locker].id, action: false)
                        //                                            dbQuery.lockers[3][dbQuery.curLockers[3][locker].id - 1].isOccupied = false
                        //                                            dbQuery.lockers[3][dbQuery.curLockers[3][locker].id - 1].userId = ""
                        //                                            dbQuery.curLockers[3].remove(at: locker)
                        //
                        //                                            print("\(dbQuery.curLockers[3].count)")
                        //                                        }
                        //                                    }
                        //                                }
                        //                            }
                        //                        }
                        //                    }
                        
                        //                .listRowInsets(.init(top:0, leading: 30, bottom: 0, trailing: 30))
                        
                    }
                    .listRowInsets(.init(top:10, leading: 15, bottom: 0, trailing: 15))
                    .listRowBackground(Color(red: 0.9254901960784314, green: 0.9607843137254902, blue: 0.9686274509803922))
                        
                    }
                    
                    .scrollContentBackground(.hidden)
                    
                    
                    HStack{
                        Text("January").padding([.top,.trailing],20)
                            .padding([.bottom],10)
                        Text("February").padding([.top,.trailing],20)
                            .padding([.bottom],10)
                        Text("March")
                            .padding([.top,.trailing],20)
                            .padding([.bottom],10)
                            .underline()
                        
                    }
                    
                    List{VStack(alignment: .leading){
                        Text("Today, 2023-03-17").font(Font.headline.weight(.bold))
                            .foregroundColor(.black)
                        Divider()
                        HStack{
                            Label("Clock-in", systemImage: "clock.badge.checkmark")
                                .foregroundColor(Color(red: 0.118, green: 0.118, blue: 0.118))
                            Spacer()
                            Text("13.22").font(Font.headline.weight(.bold))
                                .foregroundColor(Color(red: 0.118, green: 0.118, blue: 0.118))
                        }
                        
                    }}
                    
                    
                    Spacer()
                }
                .padding()
                .padding(.top, 80)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        ZStack{
                            Image("BackgroundJudul")
                                .resizable()
                                .frame(width: 390, height:162)
                            VStack{
                                
                                
                                HStack{
                                    
                                    Text("Hi, Diana 👋")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Spacer()
                                    
                                }.padding(.leading,20)
                            }.padding(.top,140)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            
            else if(!dbQuery.curLockers[1].isEmpty){
                VStack (alignment: .leading){
                    HStack(){
                        NavigationLink(destination: SelectLockerView().navigationBarHidden(true)){
                            Label("Add Locker", systemImage: "square.split.1x2")
                                .frame(width: 155, height: 40)
                                .foregroundColor(.white)
                                .background(Color(red: -0.002, green: 0.502, blue: 0.662))
                                .cornerRadius(10)
                                .padding()
                        }
                        Label("Clock-out", systemImage: "arrow.up.circle")
                            .frame(width: 155, height: 40)
                            .foregroundColor(.white)
                            .background(Color(red: -0.002, green: 0.502, blue: 0.662))
                            .cornerRadius(10)
                        
                        
                    }.onAppear(perform:{
                        dbQuery.getCurLocker()
                    })
                    
                    
                    List{VStack(alignment: .leading){
                        Text("Currently Used Locker").font(Font.headline.weight(.bold))
                            .foregroundColor(Color(red: -0.002, green: 0.502, blue: 0.662))
                            .padding(.bottom,10)
                        //                Divider()
                        //                        .background(Color(.black))
                        
                        //if(!dbQuery.curLockers[0].isEmpty){
                        ForEach(0..<dbQuery.curLockers[1].count){ locker in
                            if locker<dbQuery.curLockers[1].count {
                                VStack{
                                    Divider()
                                        .background(Color(.gray))
                                    HStack{
                                        Label("LB\(dbQuery.curLockers[1][locker].id)", systemImage: "square.split.1x2")
                                            .foregroundColor((Color(red: -0.002, green: 0.502, blue: 0.662)))

                                        Spacer()


                                        Button(action:{

                                        }){
                                            Image(systemName: "minus.circle")
                                                .foregroundColor(.white)
                                                .font(.system(size: 20))
                                                .padding(10)
                                                .background(Color.red)
                                                .frame(width: 20, height: 20)
                                                .clipShape(Circle())
                                        }.onTapGesture {
                                            print("=========================")
                                            print(locker)
                                            print(dbQuery.curLockers)
                                            dbQuery.toggleLockers(section: "LB", id: dbQuery.curLockers[1][locker].id, action: false)
                                            dbQuery.lockers[1][dbQuery.curLockers[1][locker].id - 1].isOccupied = false
                                            dbQuery.lockers[1][dbQuery.curLockers[1][locker].id - 1].userId = ""
                                            dbQuery.curLockers[1].remove(at: locker)

                                            print("\(dbQuery.curLockers[1].count)")
                                        }
                                    }
                                    .frame(height: 44)
                                    .padding()
                                }
                            }
                        }
                    
                       // }
                        //                    if(!dbQuery.curLockers[1].isEmpty){

                        //                    if(!dbQuery.curLockers[2].isEmpty){
                        //                        ForEach(0..<dbQuery.curLockers[2].count){ locker in
                        //                            if locker<dbQuery.curLockers[2].count {
                        //                                VStack{
                        //                                    Divider()
                        //                                        .background(Color(.gray))
                        //                                    HStack{
                        //                                        Label("PA\(dbQuery.curLockers[2][locker].id)", systemImage: "iconLocker")
                        //
                        //                                        Spacer()
                        //
                        //
                        //                                        Button(action:{
                        //
                        //                                        }){
                        //                                            Image(systemName: "minus.circle")
                        //                                                .foregroundColor(.white)
                        //                                                .font(.system(size: 20))
                        //                                                .padding(10)
                        //                                                .background(Color.red)
                        //                                                .frame(width: 20, height: 20)
                        //                                                .clipShape(Circle())
                        //                                        }.onTapGesture {
                        //                                            print("=========================")
                        //                                            print(locker)
                        //                                            print(dbQuery.curLockers)
                        //                                            dbQuery.toggleLockers(section: "PA", id: dbQuery.curLockers[2][locker].id, action: false)
                        //                                            dbQuery.lockers[2][dbQuery.curLockers[2][locker].id - 1].isOccupied = false
                        //                                            dbQuery.lockers[2][dbQuery.curLockers[2][locker].id - 1].userId = ""
                        //                                            dbQuery.curLockers[2].remove(at: locker)
                        //
                        //                                            print("\(dbQuery.curLockers[2].count)")
                        //                                        }
                        //                                    }
                        //                                }
                        //                            }
                        //                        }
                        //                    }
                        //                    if(!dbQuery.curLockers[3].isEmpty){
                        //                        ForEach(0..<dbQuery.curLockers[3].count){ locker in
                        //                            if locker<dbQuery.curLockers[3].count {
                        //                                VStack{
                        //                                    Divider()
                        //                                        .background(Color(.gray))
                        //                                    HStack{
                        //                                        Label("PB\(dbQuery.curLockers[3][locker].id)", systemImage: "iconLocker")
                        //
                        //                                        Spacer()
                        //
                        //
                        //                                        Button(action:{
                        //
                        //                                        }){
                        //                                            Image(systemName: "minus.circle")
                        //                                                .foregroundColor(.white)
                        //                                                .font(.system(size: 20))
                        //                                                .padding(10)
                        //                                                .background(Color.red)
                        //                                                .frame(width: 20, height: 20)
                        //                                                .clipShape(Circle())
                        //                                        }.onTapGesture {
                        //                                            print("=========================")
                        //                                            print(locker)
                        //                                            print(dbQuery.curLockers)
                        //                                            dbQuery.toggleLockers(section: "PB", id: dbQuery.curLockers[3][locker].id, action: false)
                        //                                            dbQuery.lockers[3][dbQuery.curLockers[3][locker].id - 1].isOccupied = false
                        //                                            dbQuery.lockers[3][dbQuery.curLockers[3][locker].id - 1].userId = ""
                        //                                            dbQuery.curLockers[3].remove(at: locker)
                        //
                        //                                            print("\(dbQuery.curLockers[3].count)")
                        //                                        }
                        //                                    }
                        //                                }
                        //                            }
                        //                        }
                        //                    }
                        
                        //                .listRowInsets(.init(top:0, leading: 30, bottom: 0, trailing: 30))
                        
                    }
                    .listRowInsets(.init(top:10, leading: 15, bottom: 0, trailing: 15))
                    .listRowBackground(Color(red: 0.9254901960784314, green: 0.9607843137254902, blue: 0.9686274509803922))
                        
                    }
                   
                    .scrollContentBackground(.hidden)
                    
                    
                    HStack{
                        Text("January").padding([.top,.trailing],20)
                            .padding([.bottom],10)
                        Text("February").padding([.top,.trailing],20)
                            .padding([.bottom],10)
                        Text("March")
                            .padding([.top,.trailing],20)
                            .padding([.bottom],10)
                            .underline()
                        
                    }
                    
                    List{VStack(alignment: .leading){
                        Text("Today, 2023-03-17").font(Font.headline.weight(.bold))
                            .foregroundColor(.black)
                        Divider()
                        HStack{
                            Label("Clock-in", systemImage: "clock.badge.checkmark")
                                .foregroundColor(Color(red: 0.118, green: 0.118, blue: 0.118))
                            Spacer()
                            Text("13.22").font(Font.headline.weight(.bold))
                                .foregroundColor(Color(red: 0.118, green: 0.118, blue: 0.118))
                        }
                        
                    }}
                    
                    
                    Spacer()
                }
                .padding()
                .padding(.top, 80)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        ZStack{
                            Image("BackgroundJudul")
                                .resizable()
                                .frame(width: 390, height:162)
                            VStack{
                                
                                
                                HStack{
                                    
                                    Text("Hi, Diana 👋")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Spacer()
                                    
                                }.padding(.leading,20)
                            }.padding(.top,140)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            else if(!dbQuery.curLockers[2].isEmpty){
                VStack (alignment: .leading){
                    HStack(){
                        NavigationLink(destination: SelectLockerView().navigationBarHidden(true)){
                            Label("Add Locker", systemImage: "square.split.1x2")
                                .frame(width: 155, height: 40)
                                .foregroundColor(.white)
                                .background(Color(red: -0.002, green: 0.502, blue: 0.662))
                                .cornerRadius(10)
                                .padding()
                        }
                        Label("Clock-out", systemImage: "arrow.up.circle")
                            .frame(width: 155, height: 40)
                            .foregroundColor(.white)
                            .background(Color(red: -0.002, green: 0.502, blue: 0.662))
                            .cornerRadius(10)
                        
                        
                    }.onAppear(perform:{
                        dbQuery.getCurLocker()
                    })
                    
                    
                    List{VStack(alignment: .leading){
                        Text("Currently Used Locker").font(Font.headline.weight(.bold))
                            .foregroundColor(Color(red: -0.002, green: 0.502, blue: 0.662))
                            .padding(.bottom,10)
                        //                Divider()
                        //                        .background(Color(.black))
                        
                        //if(!dbQuery.curLockers[0].isEmpty){
                        ForEach(0..<dbQuery.curLockers[2].count){ locker in
                            if locker<dbQuery.curLockers[2].count {
                                VStack{
                                    Divider()
                                        .background(Color(.gray))
                                    HStack{
                                        Label("PA\(dbQuery.curLockers[2][locker].id)", systemImage: "square.split.1x2")
                                            .foregroundColor((Color(red: -0.002, green: 0.502, blue: 0.662)))

                                        Spacer()


                                        Button(action:{

                                        }){
                                            Image(systemName: "minus.circle")
                                                .foregroundColor(.white)
                                                .font(.system(size: 20))
                                                .padding(10)
                                                .background(Color.red)
                                                .frame(width: 20, height: 20)
                                                .clipShape(Circle())
                                        }.onTapGesture {
                                            print("=========================")
                                            print(locker)
                                            print(dbQuery.curLockers)
                                            dbQuery.toggleLockers(section: "PA", id: dbQuery.curLockers[2][locker].id, action: false)
                                            dbQuery.lockers[2][dbQuery.curLockers[2][locker].id - 1].isOccupied = false
                                            dbQuery.lockers[2][dbQuery.curLockers[2][locker].id - 1].userId = ""
                                            dbQuery.curLockers[2].remove(at: locker)

                                            print("\(dbQuery.curLockers[2].count)")
                                        }
                                    }
                                    .frame(height: 44)
                                    .padding()
                                }
                            }
                        }
                    
                       // }
                        //                    if(!dbQuery.curLockers[1].isEmpty){

                        //                    if(!dbQuery.curLockers[2].isEmpty){

                        //                    if(!dbQuery.curLockers[3].isEmpty){
                        //                        ForEach(0..<dbQuery.curLockers[3].count){ locker in
                        //                            if locker<dbQuery.curLockers[3].count {
                        //                                VStack{
                        //                                    Divider()
                        //                                        .background(Color(.gray))
                        //                                    HStack{
                        //                                        Label("PB\(dbQuery.curLockers[3][locker].id)", systemImage: "iconLocker")
                        //
                        //                                        Spacer()
                        //
                        //
                        //                                        Button(action:{
                        //
                        //                                        }){
                        //                                            Image(systemName: "minus.circle")
                        //                                                .foregroundColor(.white)
                        //                                                .font(.system(size: 20))
                        //                                                .padding(10)
                        //                                                .background(Color.red)
                        //                                                .frame(width: 20, height: 20)
                        //                                                .clipShape(Circle())
                        //                                        }.onTapGesture {
                        //                                            print("=========================")
                        //                                            print(locker)
                        //                                            print(dbQuery.curLockers)
                        //                                            dbQuery.toggleLockers(section: "PB", id: dbQuery.curLockers[3][locker].id, action: false)
                        //                                            dbQuery.lockers[3][dbQuery.curLockers[3][locker].id - 1].isOccupied = false
                        //                                            dbQuery.lockers[3][dbQuery.curLockers[3][locker].id - 1].userId = ""
                        //                                            dbQuery.curLockers[3].remove(at: locker)
                        //
                        //                                            print("\(dbQuery.curLockers[3].count)")
                        //                                        }
                        //                                    }
                        //                                }
                        //                            }
                        //                        }
                        //                    }
                        
                        //                .listRowInsets(.init(top:0, leading: 30, bottom: 0, trailing: 30))
                        
                    }
                    .listRowInsets(.init(top:10, leading: 15, bottom: 0, trailing: 15))
                    .listRowBackground(Color(red: 0.9254901960784314, green: 0.9607843137254902, blue: 0.9686274509803922))
                        
                    }
                    
                    .scrollContentBackground(.hidden)
                    
                    
                    HStack{
                        Text("January").padding([.top,.trailing],20)
                            .padding([.bottom],10)
                        Text("February").padding([.top,.trailing],20)
                            .padding([.bottom],10)
                        Text("March")
                            .padding([.top,.trailing],20)
                            .padding([.bottom],10)
                            .underline()
                        
                    }
                    
                    List{VStack(alignment: .leading){
                        Text("Today, 2023-03-17").font(Font.headline.weight(.bold))
                            .foregroundColor(.black)
                        Divider()
                        HStack{
                            Label("Clock-in", systemImage: "clock.badge.checkmark")
                                .foregroundColor(Color(red: 0.118, green: 0.118, blue: 0.118))
                            Spacer()
                            Text("13.22").font(Font.headline.weight(.bold))
                                .foregroundColor(Color(red: 0.118, green: 0.118, blue: 0.118))
                        }
                        
                    }}
                    
                    
                    Spacer()
                }
                .padding()
                .padding(.top, 80)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        ZStack{
                            Image("BackgroundJudul")
                                .resizable()
                                .frame(width: 390, height:162)
                            VStack{
                                
                                
                                HStack{
                                    
                                    Text("Hi, Diana 👋")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Spacer()
                                    
                                }.padding(.leading,20)
                            }.padding(.top,140)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            else if(!dbQuery.curLockers[3].isEmpty){
                VStack (alignment: .leading){
                    HStack(){
                        NavigationLink(destination: SelectLockerView().navigationBarHidden(true)){
                            Label("Add Locker", systemImage: "square.split.1x2")
                                .frame(width: 155, height: 40)
                                .foregroundColor(.white)
                                .background(Color(red: -0.002, green: 0.502, blue: 0.662))
                                .cornerRadius(10)
                                .padding()
                        }
                        Label("Clock-out", systemImage: "arrow.up.circle")
                            .frame(width: 155, height: 40)
                            .foregroundColor(.white)
                            .background(Color(red: -0.002, green: 0.502, blue: 0.662))
                            .cornerRadius(10)
                        
                        
                    }.onAppear(perform:{
                        dbQuery.getCurLocker()
                    })
                    
                    
                    List{VStack(alignment: .leading){
                        Text("Currently Used Locker").font(Font.headline.weight(.bold))
                            .foregroundColor(Color(red: -0.002, green: 0.502, blue: 0.662))
                            .padding(.bottom,10)
                        //                Divider()
                        //                        .background(Color(.black))
                        
                        //if(!dbQuery.curLockers[0].isEmpty){
                        ForEach(0..<dbQuery.curLockers[3].count){ locker in
                            if locker<dbQuery.curLockers[3].count {
                                VStack{
                                    Divider()
                                        .background(Color(.gray))
                                    HStack{
                                        Label("PB\(dbQuery.curLockers[3][locker].id)", systemImage: "square.split.1x2")
                                            .foregroundColor((Color(red: -0.002, green: 0.502, blue: 0.662)))

                                        Spacer()


                                        Button(action:{

                                        }){
                                            Image(systemName: "minus.circle")
                                                .foregroundColor(.white)
                                                .font(.system(size: 20))
                                                .padding(10)
                                                .background(Color.red)
                                                .frame(width: 20, height: 20)
                                                .clipShape(Circle())
                                        }.onTapGesture {
                                            print("=========================")
                                            print(locker)
                                            print(dbQuery.curLockers)
                                            dbQuery.toggleLockers(section: "PB", id: dbQuery.curLockers[3][locker].id, action: false)
                                            dbQuery.lockers[3][dbQuery.curLockers[3][locker].id - 1].isOccupied = false
                                            dbQuery.lockers[3][dbQuery.curLockers[3][locker].id - 1].userId = ""
                                            dbQuery.curLockers[3].remove(at: locker)

                                            print("\(dbQuery.curLockers[3].count)")
                                        }
                                    }
                                    .frame(height: 44)
                                    .padding()
                                }
                            }
                        }
                    

                
                    
                       // }
                        //                    if(!dbQuery.curLockers[1].isEmpty){

                        //                    if(!dbQuery.curLockers[2].isEmpty){

                        //                    if(!dbQuery.curLockers[3].isEmpty){

                        
                    }
                    .listRowInsets(.init(top:10, leading: 15, bottom: 0, trailing: 15))
                    .listRowBackground(Color(red: 0.9254901960784314, green: 0.9607843137254902, blue: 0.9686274509803922))
                        
                    }
                    
                    .scrollContentBackground(.hidden)
                    
                    
                    HStack{
                        Text("January").padding([.top,.trailing],20)
                            .padding([.bottom],10)
                        Text("February").padding([.top,.trailing],20)
                            .padding([.bottom],10)
                        Text("March")
                            .padding([.top,.trailing],20)
                            .padding([.bottom],10)
                            .underline()
                        
                    }
                    
                    List{VStack(alignment: .leading){
                        Text("Today, 2023-03-17").font(Font.headline.weight(.bold))
                            .foregroundColor(.black)
                        Divider()
                        HStack{
                            Label("Clock-in", systemImage: "clock.badge.checkmark")
                                .foregroundColor(Color(red: 0.118, green: 0.118, blue: 0.118))
                            Spacer()
                            Text("13.22").font(Font.headline.weight(.bold))
                                .foregroundColor(Color(red: 0.118, green: 0.118, blue: 0.118))
                        }
                        
                    }}
                    
                    
                    Spacer()
                }
                .padding()
                .padding(.top, 80)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        ZStack{
                            Image("BackgroundJudul")
                                .resizable()
                                .frame(width: 390, height:162)
                            VStack{
                                
                                
                                HStack{
                                    
                                    Text("Hi, Diana 👋")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Spacer()
                                    
                                }.padding(.leading,20)
                            }.padding(.top,140)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            else{
                VStack (alignment: .leading){
                    HStack(){
                        NavigationLink(destination: SelectLockerView().navigationBarHidden(true)){
                            Label("Use Locker", systemImage: "square.split.1x2")
                                .frame(width: 155, height: 40)
                                .foregroundColor(.white)
                                .background(Color(red: -0.002, green: 0.502, blue: 0.662))
                                .cornerRadius(10)
                                .padding()
                        }
                        Label("Clock-out", systemImage: "arrow.up.circle")
                            .frame(width: 155, height: 40)
                            .foregroundColor(.white)
                            .background(Color(red: -0.002, green: 0.502, blue: 0.662))
                            .cornerRadius(10)
                        
                        
                    }.onAppear(perform:{
                        dbQuery.getCurLocker()
                    })
                    
                    HStack{
                        Text("January").padding([.top,.trailing],20)
                            .padding([.bottom],10)
                        Text("February").padding([.top,.trailing],20)
                            .padding([.bottom],10)
                        Text("March")
                            .padding([.top,.trailing],20)
                            .padding([.bottom],10)
                            .underline()
                        
                    }
                    
                    List{VStack(alignment: .leading){
                        Text("Today, 2023-03-17").font(Font.headline.weight(.bold))
                            .foregroundColor(.black)
                        Divider()
                        HStack{
                            Label("Clock-in", systemImage: "clock.badge.checkmark")
                                .foregroundColor(Color(red: 0.118, green: 0.118, blue: 0.118))
                            Spacer()
                            Text("13.22").font(Font.headline.weight(.bold))
                                .foregroundColor(Color(red: 0.118, green: 0.118, blue: 0.118))
                        }
                        
                    }}
                    
                    
                    Spacer()
                }
                .padding()
                .padding(.top, 80)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        ZStack{
                            Image("BackgroundJudul")
                                .resizable()
                                .frame(width: 390, height:162)
                            VStack{
                                
                                
                                HStack{
                                    
                                    Text("Hi, Diana 👋")
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                    Spacer()
                                    
                                }.padding(.leading,20)
                            }.padding(.top,140)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
                
        }
    }
}

struct AfterChooseLockerView_Previews: PreviewProvider {
    static var previews: some View {
        AfterChooseLockerView(isOk: .constant(true))
    }
}
