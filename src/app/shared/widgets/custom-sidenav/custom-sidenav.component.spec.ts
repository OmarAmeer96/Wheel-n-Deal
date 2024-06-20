import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CustomSidenavComponent } from './custom-sidenav.component';

describe('CustomSidenavComponent', () => {
  let component: CustomSidenavComponent;
  let fixture: ComponentFixture<CustomSidenavComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CustomSidenavComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(CustomSidenavComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
